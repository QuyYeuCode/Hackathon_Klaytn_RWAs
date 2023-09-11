import classNames from 'classnames/bind';
import styles from './infomation.module.scss';
import img from './img/img1.png';
const cx = classNames.bind(styles);
function Information() {
    return (
        <div className={cx('wrapper')}>
            <h1>QuHuTe is banking simplified</h1>
            <h3>
                Simplify money transference with tools that empower you to take control of your money and pave the way
                to prosperity.
            </h3>
            <div className={cx('img')}>
                <a href="#">
                    <img src="https://framerusercontent.com/images/kSlWGpQo2J7b4W5yP9mrMHshI8.png" />
                    <div className={cx('buttom')}>
                        <h3>Trusted by modern startups</h3>
                        <div>
                            <img src={img} />
                        </div>
                    </div>
                </a>
            </div>
        </div>
    );
}
export default Information;
