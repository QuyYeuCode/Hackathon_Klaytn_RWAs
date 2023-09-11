// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

interface ITokenGold {
    function transfer(address, uint256) external returns (bool);

    function transferFrom(address, address, uint256) external returns (bool);

    function balanceOf(address) external returns (uint256);
}

import {IAggregator} from "@bisonai/orakl-contracts/src/v0.1/interfaces/IAggregator.sol";

contract Lending {
    IAggregator internal dataFeed;
    ITokenGold public tokenGold;

    // for mainet Cypress 0x33d6ee12d4ade244100f09b280e159659fe0ace0
    // for testnet Baobab 0xC874f389A3F49C5331490145f77c4eFE202d72E1
    constructor(address _tokenGold) {
        dataFeed = IAggregator(0xC874f389A3F49C5331490145f77c4eFE202d72E1);
        tokenGold = ITokenGold(_tokenGold);
    }

    function getLatestData() public view returns (int256) {
        (, int256 answer, , , ) = dataFeed.latestRoundData();
        return answer;
    }

    function decimals() public view returns (uint8) {
        return dataFeed.decimals();
    }

    receive() external payable {}

    // tổng giá trị người cho vay đặt lên sàn hiện tại ~ nguồn cung
    uint256 public totalSupply = 0;

    // lãi suất mặc định của sàn
    uint256 public interestRate = 5;

    uint256 public indOfLoan = 0;

    // thời hạn 1 năm
    uint256 public endTime = 365 days;

    // Chưa biết thêm thuộc tính balance kiểu gì

    struct Lender {
        address _lender; // địa chỉ của người cho vay
        uint256 deposited; // tổng số tiền đang đặt ở trên sàn vay
        uint256 interestRate; // mức lãi suất mà họ đặt
        uint256 totalLender; // tổng số tiền đang cho vay hiện tại
    }

    struct Borrower {
        address _borrower;
        //uint256 currentOfCollateral; // giá trị hiện tài của số vàng mã hóa mà người đi vay sở hữu
    }

    struct Loan {
        address _lender;
        address _borrower;
        uint256 amountBorrow; // số tiền vay
        uint256 ind;
        uint256 timeBorrow;
        uint256 interestRate;
        uint256 needToPay;
        uint256 lastUpdateTime;
        uint256 endTimeToRepay;
    }

    struct checkLender {
        address _lender;
        uint256 deposited;
        uint256 interestRate;
    }

    // map địa chỉ với thông tin người cho vay
    mapping(address => Lender) public aToL;

    // map địa chỉ với thông tin người đi vay
    mapping(address => Borrower) public aToB;

    // map địa chỉ người cho vay với danh sách các hợp đồng cho vay của họ
    mapping(address => Loan[]) public aToLo1;

    //map địa chỉ của người vay với danh sách các hợp đồng vay của họ

    mapping(address => Loan[]) public aToLo2;

    // lưu từng người đã ký gửi
    Lender[] public ListOfLender;
    // Lưu người đi vay
    Borrower[] public ListOfBorrower;
    // Lưu các hợp đồng vay
    Loan[] public ListOfLoan;

    event _Deposit(address indexed depositer, uint256 amount);
    event _WithDraw(address indexed sender, uint256 amount);
    event _SetNewRate(address lender, uint256 newRate);
    event _Borrow(
        address indexed lender,
        address indexed borrower,
        uint256 ind,
        uint256 amount,
        uint256 timeToBorrow
    );
    event _RePay(
        address indexed borrower,
        uint256 ind,
        uint256 amount,
        uint256 timeToRepay
    );

    // hàm để check xem địa chỉ có phải là của người cho vay hay không
    function isLender(address _needCheck) public view returns (bool) {
        uint256 len = ListOfLender.length;
        for (uint256 i = 0; i < len; i++) {
            if (_needCheck == ListOfLender[i]._lender) return true;
        }
        return false;
    }

    // hàm chỉ dành cho người cho vay
    modifier onlyLender() {
        bool checklender = isLender(msg.sender);
        require(checklender, "You don't have permission to do this action");
        _;
    }

    // Hàm trả về danh sách người cho vay
    function checkAllLenderDeposit() public view returns (Lender[] memory) {
        uint256 len = ListOfLender.length;
        uint256 ind = 0;
        Lender[] memory tmpListOfLender = new Lender[](len);
        for (uint i = 0; i < len; i++) {
            if (ListOfLender[i]._lender != address(0)) {
                tmpListOfLender[ind] = ListOfLender[i];
                ind++;
            }
        }
        return tmpListOfLender;
    }

    // hàm để check địa chỉ, số tiền có thể cho vay và lãi suất hiện tại của tất cả người cho vay
    function checkinterestRate() public view returns (checkLender[] memory) {
        uint256 len = ListOfLender.length;
        uint256 ind = 0;
        Lender[] memory tmpListOfLender = new Lender[](len);
        for (uint i = 0; i < len; i++) {
            if (ListOfLender[i]._lender != address(0)) {
                tmpListOfLender[ind] = ListOfLender[i];
                ind++;
            }
        }

        checkLender[] memory lender = new checkLender[](len);

        for (uint256 i = 0; i < ind; i++) {
            lender[i]._lender = tmpListOfLender[i]._lender;
            lender[i].deposited = tmpListOfLender[i].deposited;
            lender[i].interestRate = tmpListOfLender[i].interestRate;
        }
        return lender; //  => trả về từng người với các thông tin trên
    }

    // hàm set lãi suất dành cho trang của người cho vay
    function setInterestRate(uint256 _newRate) public onlyLender {
        require(
            _newRate < 9 && _newRate > 0, // chưa tham khảo được điều kiện lãi suất
            "Your new interest rate is too high or too low"
        );
        aToL[msg.sender].interestRate = _newRate;
        emit _SetNewRate(msg.sender, _newRate);
    }

    // hàm dùng để người cho vay ký gửi và lưu trữ trên hợp đồng
    function Deposit(uint256 amount) public payable {
        require(amount > 0, "Please deposit bigger than 0");
        require(
            address(msg.sender).balance >= amount,
            "Your balance is not enough"
        );

        payable(address(this)).transfer(amount);
        if (!isLender(msg.sender)) {
            ListOfLender.push(Lender(msg.sender, 0, 0, 0));
            aToL[msg.sender] = ListOfLender[ListOfLender.length - 1];

            setInterestRate(interestRate); // Mặc định lãi suất là 5 khi người cho vay mới gửi tiền lần đầu

            aToL[msg.sender].deposited += amount;
        } else {
            aToL[msg.sender].deposited += amount;
        }

        totalSupply += amount;

        emit _Deposit(msg.sender, amount);
    }

    // Hàm để người cho vay check thông tin của họ
    function checkLenderDeposit()
        public
        view
        onlyLender
        returns (address, uint256, uint256, uint256, Loan[] memory)
    {
        return (
            aToL[msg.sender]._lender,
            aToL[msg.sender].deposited,
            aToL[msg.sender].interestRate,
            aToL[msg.sender].totalLender,
            aToLo1[msg.sender]
        );
    }

    // hàm để người cho vay để rút lại tiền
    function withDraw(uint256 amount) public payable onlyLender {
        require(amount > 0, "Please deposit bigger than 0");
        require(
            amount <= aToL[msg.sender].deposited,
            "Your withdraw amount is too high"
        );

        bool success = payable(msg.sender).send(amount);

        if (success) {
            uint256 currenDeposit = aToL[msg.sender].deposited - amount;
            aToL[msg.sender] = Lender(
                msg.sender,
                currenDeposit,
                interestRate,
                aToL[msg.sender].totalLender
            );
            totalSupply -= amount;

            //     Kiểm tra xem nếu người này đang có đồng thời deposited = 0 và totalLender = 0
            //     thì loại bỏ khỏi danh sách người cho vay

            if (currenDeposit == 0 && aToL[msg.sender].totalLender == 0) {
                uint256 len = ListOfLender.length;
                for (uint i = 0; i < len; i++) {
                    if (ListOfLender[i]._lender == msg.sender) {
                        delete ListOfLender[i];
                    }
                }
            }
        }

        emit _WithDraw(msg.sender, amount);
    }

    // hàm check xem một người có đang vay hay không
    function isBorrower(address borrow) public view returns (bool) {
        uint256 len = ListOfBorrower.length;
        for (uint256 i = 0; i < len; i++) {
            if (borrow == ListOfBorrower[i]._borrower) return true;
        }
        return false;
    }

    // hàm để người vay vay 1 số tiền
    function Borrow(address lender, uint256 amount) public payable {
        if (!isBorrower(msg.sender)) {
            ListOfBorrower.push(Borrower(msg.sender));
            //
            // Chưa biết xử lí phần khởi tạo dữ liệu cho borrower
        }
        // require(
        //     aToB[msg.sender].ownerOfGoldToken,
        //     "You don't have a gold token to borrow"
        // );
        require(
            aToL[lender].deposited > amount,
            "Please borrow less than the lender's amount"
        );
        require(
            (tokenGold.balanceOf(msg.sender) * 80) / 100 >= amount,
            "Please borrow less than 80% your current of collateral"
        );
        tokenGold.transfer(address(this), tokenGold.balanceOf(msg.sender));
        bool success = payable(address(msg.sender)).send(amount);

        if (success) {
            aToL[lender].deposited -= amount;
            totalSupply -= amount;

            ListOfLoan.push(
                Loan(
                    lender,
                    msg.sender,
                    amount, // số tiền vay
                    indOfLoan,
                    block.timestamp,
                    aToL[lender].interestRate,
                    amount,
                    block.timestamp,
                    block.timestamp + endTime
                )
            );

            uint256 len = ListOfLoan.length;
            aToLo1[lender].push(ListOfLoan[len - 1]);
            aToLo2[msg.sender].push(ListOfLoan[len - 1]);

            emit _Borrow(
                lender,
                msg.sender,
                indOfLoan,
                amount,
                block.timestamp
            );

            indOfLoan++;
        }
    }

    // Hàm update tất cả các khoản cho vay hiện tại của người cho vay
    function updateNeedToPay1() public onlyLender {
        uint256 len = aToLo1[msg.sender].length;
        for (uint i = 0; i < len; i++) {
            if (aToLo1[msg.sender][i]._lender != address(0)) {
                aToLo1[msg.sender][i].needToPay +=
                    (aToLo1[msg.sender][i].amountBorrow *
                        ((aToLo1[msg.sender][i].interestRate *
                            (block.timestamp -
                                aToLo1[msg.sender][i].timeBorrow)) /
                            (60 * 60 * 24 * 365))) /
                    100;
                aToLo1[msg.sender][i].lastUpdateTime = block.timestamp;
            }
        }
    }

    // Hàm update tất cả các khoản vay hiện tại của người vay
    function updateNeedToPay2() public {
        uint256 len = aToLo2[msg.sender].length;
        for (uint i = 0; i < len; i++) {
            if (aToLo2[msg.sender][i]._lender != address(0)) {
                aToLo2[msg.sender][i].needToPay +=
                    (aToLo2[msg.sender][i].amountBorrow *
                        ((aToLo2[msg.sender][i].interestRate *
                            (block.timestamp -
                                aToLo2[msg.sender][i].timeBorrow)) /
                            (60 * 60 * 24 * 365))) /
                    100;
                aToLo2[msg.sender][i].lastUpdateTime = block.timestamp;
            }
        }
    }

    // hàm cho người đi vay trả tiền
    function rePay(uint256 _ind, uint256 amount) public payable {
        require(
            ListOfLoan[_ind]._lender != address(0),
            "This loan does not exsist"
        );

        require(
            msg.sender.balance >= amount,
            "Your balance of wallet must be at least amount"
        );

        updateNeedToPay2();
        updateNeedToPay1();

        require(
            (0 < amount && amount <= ListOfLoan[_ind].needToPay),
            "Invalid payment amount"
        );
        payable(address(this)).transfer(amount);
        bool success = payable(ListOfLoan[_ind]._lender).send(amount);
        if (success) {
            ListOfLoan[_ind].needToPay -= amount;

            // Nếu người này trả hết khoản vay ==> xóa khoản vay
            if (ListOfLoan[_ind].needToPay == 0) {
                address _lender = ListOfLoan[_ind]._lender;
                delete (ListOfLoan[_ind]);

                uint256 len1 = aToLo1[_lender].length;
                for (uint i = 0; i < len1; i++) {
                    if (aToLo1[_lender][i].ind == _ind) {
                        delete aToLo1[_lender][i];
                        break;
                    }
                }
                uint256 len2 = aToLo2[msg.sender].length;
                for (uint i = 0; i < len2; i++) {
                    if (aToLo2[msg.sender][i].ind == _ind) {
                        delete aToLo2[msg.sender][i];
                        break;
                    }
                }
                // Nếu người này không còn nợ ai nữa ==> Xóa trong danh sách người đi vay
                bool tmp = false;
                for (uint i = 0; i < len2; i++) {
                    if (aToLo2[msg.sender][i].needToPay != 0) {
                        tmp = true;
                        break;
                    }
                }
                uint len = ListOfBorrower.length;
                if (!tmp) {
                    for (uint i = 0; i < len; i++) {
                        if (ListOfBorrower[i]._borrower == msg.sender) {
                            delete ListOfBorrower[i];
                        }
                    }
                }
            }

            emit _RePay(msg.sender, _ind, amount, block.timestamp);
        }
    }

    // hàm lấy thông tin của người vay => nằm ở trang 3
    function getInforBorrower(
        address _borrower
    ) public view returns (Loan[] memory) {
        // tạm thời là như vậy
        return (aToLo2[_borrower]);
    }

    // hàm để người cho vay lấy token
    function claimToken(address borrower) public onlyLender {
        Loan[] memory loan = aToLo1[msg.sender];

        uint256 len = loan.length;

        uint256 index = 0;
        bool endedTime = false;

        for (index = 0; index < len; index++) {
            if (loan[index]._borrower == borrower) {
                break;
            }
            index++;
        }

        if (block.timestamp >= loan[index].endTimeToRepay) {
            endedTime = true;
        }

        require(
            loan[index].amountBorrow >=
                tokenGold.balanceOf(loan[index]._borrower)
        );
        require(endedTime, "Still have time to pay");
        tokenGold.transferFrom(
            address(this),
            msg.sender,
            tokenGold.balanceOf(loan[index]._borrower)
        );

        aToLo1[msg.sender][index].needToPay = 0;
        aToLo2[borrower][index].needToPay = 0;
        ListOfLoan[index].needToPay = 0;
        //address _lender = ListOfLoan[index]._lender;
        delete (ListOfLoan[index]);

        uint256 len1 = aToLo1[msg.sender].length;
        for (uint i = 0; i < len1; i++) {
            if (aToLo1[msg.sender][i]._borrower == borrower) {
                delete aToLo1[msg.sender][i];
                break;
            }
        }
        uint256 len2 = aToLo2[borrower].length;
        for (uint i = 0; i < len2; i++) {
            if (aToLo2[borrower][i]._borrower == borrower) {
                delete aToLo2[borrower][i];
                break;
            }
        }
        // Nếu người borrower không còn nợ ai nữa ==> Xóa trong danh sách người đi vay
        bool tmp = false;
        for (uint i = 0; i < len2; i++) {
            if (aToLo2[borrower][i].needToPay != 0) {
                tmp = true;
                break;
            }
        }
        uint256 len3 = ListOfBorrower.length;
        if (!tmp) {
            for (uint i = 0; i < len3; i++) {
                if (ListOfBorrower[i]._borrower == borrower) {
                    delete ListOfBorrower[i];
                }
            }
        }
    }

    // kiểm tra tổng nguồn cung => nằm ở trang 1
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }
}
