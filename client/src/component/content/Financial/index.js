import classNames from 'classnames/bind';
import styles from './Financial.module.scss';
import img1 from './Financial1.png';
import img2 from './Financial2.png';
import img3 from './Financial3.png';
import img4 from './Financial4.png';
import img5 from './Financial5.png';
import img01 from './img1.png';
import img02 from './img2.png';
import img03 from './img3.png';

const cx = classNames.bind(styles);
function Financial() {
    return (
        <div className={cx('wrapper')}>
            <div className={cx('content')}>
                <div className={cx('header')}>
                    <h1>Financial Freedom, Simplified.</h1>
                    <h3>
                        eKYC is the money transference platform for the 21st century, get tailored support and
                        suggestions to grow your earning potential.
                    </h3>
                </div>
                <div className={cx('img')}>
                    <div className={cx('img1')}>
                        <img src={img1} />
                    </div>
                    <div className={cx('img2')}>
                        <img src={img2} />
                        <div className={cx('click1')}>
                            <button className={cx('item1')}>
                                <h4>Auto Investment</h4>
                                <p>
                                    Allow MoneyWise to automatically invest on your behalf, just set it and forget it.
                                </p>
                            </button>
                            <button className={cx('item2')}>
                                <h4>Auto Pay</h4>
                                <p>Allow MoneyWise to automatically pay off your debt each month.</p>
                            </button>
                        </div>
                        <div className={cx('click2')}>
                            <button className={cx('item3')}>
                                <h4>You're on track to reach your budget goal this month 🎉</h4>
                            </button>
                        </div>
                    </div>
                </div>
                <div className={cx('info')} id="benefits">
                    <div className={cx('left')}>
                        <h1>Financial Freedom, Simplified.</h1>
                        <h3>
                            MoneyWise is the money management platform for the 21st century, get tailored support and
                            suggestions to grow your earning poteintial.
                        </h3>
                        <div className={cx('tab-item')}>
                            <h2 className={cx('header-item')}>Secure 2FA Protection</h2>
                            <p className={cx('content-item')}>
                                Enhanced security with 2FA, safeguarding your financial information.
                            </p>
                        </div>
                        <div className={cx('tab-item', 'active')}>
                            <h2 className={cx('header-item')}>Dedicated Support</h2>
                            <p className={cx('content-item', 'content-active')}>
                                Our dedicated support team ensures a smooth and fulfilling financial journey.
                            </p>
                        </div>
                        <div className={cx('tab-item')}>
                            <h2 className={cx('header-item')}>Money Insights</h2>
                            <p className={cx('content-item')}>
                                Effortlessly track their daily expenses and categorize them for better visibility.
                            </p>
                        </div>
                    </div>
                    <div className={cx('right')}>
                        <div className={cx('img-item')}>
                            <img src={img01} />
                        </div>
                        <div className={cx('img-item', 'img-active')}>
                            <img src={img02} />
                        </div>
                        <div className={cx('img-item')}>
                            <img src={img03} />
                        </div>
                    </div>
                </div>
            </div>
            <div className={cx('content')}>
                <div className={cx('header')}>
                    <h1>Financial Freedom, Simplified.</h1>
                    <h3>
                        MoneyWise is the money management platform for the 21st century, get tailored support and
                        suggestions to grow your earning poteintial.
                    </h3>
                </div>
                <div className={cx('img')}>
                    <div className={cx('img1')}>
                        <img src={img3} />
                    </div>
                    <div className={cx('img1')}>
                        <img src={img4} />
                    </div>
                    <div className={cx('img1')}>
                        <img src={img5} />
                    </div>
                </div>
                <div className={cx('join')}>
                    <div className={cx('join_left')}>
                        <p>Sign up for MoneyWise</p>
                        <h2>Unlock Your Financial Potential Today</h2>
                        <div>
                            <a href="/#join">Total Supply</a>
                        </div>
                    </div>
                    <div className={cx('join_right')}>
                        <img src="https://framerusercontent.com/images/3oIsdFzLGSmshKu5QgenbJwX7o.png" />
                    </div>
                </div>
            </div>
        </div>
    );
}
export default Financial;
