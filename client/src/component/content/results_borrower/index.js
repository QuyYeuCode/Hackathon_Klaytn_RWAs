import classNames from 'classnames/bind';
import styles from './result.module.scss';

const cx = classNames.bind(styles);
function Results() {
    return (
        <div className={cx('wrapper')}>
            <div className={cx('cover')}>
                <div className={cx('content')}>hiển thị thông tin của tài khoản vay trong này nhé</div>
                <button className={cx('click')}>getInforBorrower</button>
            </div>
            <div className={cx('cover')}>
                <div className={cx('content')}>
                    <input type="text" placeholder="Name" />
                    <input type="text" placeholder="Address" />
                </div>
                <button className={cx('click')}>Borrower</button>
            </div>
            <div className={cx('cover')}>
                <div className={cx('content')}>
                    <input type="text" placeholder="Id" />
                    <input type="text" placeholder="Amount want to pay" />
                </div>
                <button className={cx('click')}>rePay</button>
            </div>
            <div className={cx('cover')}>
                <div className={cx('content')}>hiển thị thông tin họ vay sau khi update</div>
                <button className={cx('click')}>updateNeedToPay</button>
            </div>
            <div className={cx('cover')}>
                <div className={cx('content')}>Bảng hiển thị số người đang đầu tư</div>
                <button className={cx('click')}>checkInterestRates</button>
            </div>
        </div>
    );
}
export default Results;
