import classNames from 'classnames/bind';
import styles from './login.module.scss';
const cx = classNames.bind(styles);
function Login() {
    return (
        <div className={cx('wrapper')}>
            <h1>QuHuTe</h1>
            <div className={cx('img')}>
                <div className={cx('img1')}></div>
                <div className={cx('img2')}></div>
                <div className={cx('img3')}></div>
                <div className={cx('img4')}></div>
            </div>
            <form className={cx('form')}>
                <input type="text" placeholder="Name" className={cx('input')} />
                <input type="password" placeholder="Password" className={cx('input')} />
                <input type="submit" value="Connect" className={cx('submit')} />
            </form>
        </div>
    );
}
export default Login;
