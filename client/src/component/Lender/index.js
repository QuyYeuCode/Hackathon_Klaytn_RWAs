import classNames from 'classnames/bind';
import styles from './login.module.scss';
import Results from '../content/results_lender';
const cx = classNames.bind(styles);
function Lender() {
    return (
        <div className={cx('wrapper')}>
            <Results />
        </div>
    );
}
export default Lender;
