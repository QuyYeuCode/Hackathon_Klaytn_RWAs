import Quhute from '../content/Quhute';
import Information from '../content/infomation';
import Financial from '../content/Financial';
import Join from '../content/Join';
import classNames from 'classnames';
import styles from './home.module.scss';
const cx = classNames.bind(styles);
function Home() {
    return (
        <div className={cx('home')}>
            <Quhute />
            <Information />
            <Join />
            <Financial />
        </div>
    );
}

export default Home;
