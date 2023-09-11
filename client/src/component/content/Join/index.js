import classNames from 'classnames/bind';
import styles from './join.module.scss';
import img1 from './Join1.png';

const cx = classNames.bind(styles);
function Join() {
    return (
        <div className={cx('wrapper')} id="join">
            <img src={img1} className={cx('img')} />
            <div className={cx('content')}>
                <h2>Total Supply.</h2>
                <div className={cx('content-item')}>hiển thị thông tin tổng số tiền trong này nhé</div>
            </div>
        </div>
    );
}
export default Join;
