import classNames from 'classnames/bind';
import styles from './login.module.scss';
import Results from '../content/results_borrower';
const cx = classNames.bind(styles);
function Borrower() {
    return (
        <div className={cx('wrapper')}>
            <Results />
        </div>
    );
}
export default Borrower;
