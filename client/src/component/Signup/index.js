import classNames from 'classnames/bind';
import styles from './signup.module.scss';
const cx = classNames.bind(styles);
function Signup() {
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
                <div className={cx('form_1')}>
                    <input type="text" placeholder="Name" className={cx('name')} />
                    <input type="email" placeholder="Email" className={cx('email')} />
                </div>
                <input type="text" placeholder="Notes" className={cx('notes')} />
                <input type="submit" value="Sign up" className={cx('submit')} />
            </form>
        </div>
    );
}
export default Signup;
