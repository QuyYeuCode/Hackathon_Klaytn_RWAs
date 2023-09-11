import classNames from 'classnames/bind';
import styles from './footer.module.scss';

const cx = classNames.bind(styles);
function Footer() {
    return <div className={cx('footer')}></div>;
}

export default Footer;
