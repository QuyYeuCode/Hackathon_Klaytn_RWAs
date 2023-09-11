import classNames from 'classnames/bind';
import styles from './quhute.module.scss';
import { Link } from 'react-router-dom';
const cx = classNames.bind(styles);
function Quhute() {
    return (
        <div className={cx('wrapper')}>
            <div className={cx('left')}>
                <h1>QuHuTe</h1>
                <h3>Some description for the platform will be displayed here</h3>
                <div className={cx('click')}>
                    <Link to="/lender" className={cx('start')}>
                        Lender
                    </Link>
                    <Link to="/borrower" className={cx('more')}>
                        Borrower
                    </Link>
                </div>
            </div>
            <div className={cx('right')}>
                <iframe
                    src="https://my.spline.design/clonercubebinarycopy-fa23ba9a83dc444452853a97ef37e6de/"
                    // style="width:100%;height:100%;border:none"
                    loading="lazy"
                    fetchpriority="auto"
                    referrerpolicy="no-referrer"
                    sandbox="allow-same-origin allow-scripts allow-downloads allow-forms allow-modals allow-orientation-lock allow-pointer-lock allow-popups allow-popups-to-escape-sandbox allow-presentation allow-storage-access-by-user-activation allow-top-navigation-by-user-activation"
                ></iframe>
            </div>
        </div>
    );
}
export default Quhute;
