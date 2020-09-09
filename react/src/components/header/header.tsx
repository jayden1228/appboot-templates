import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { AppStore } from '../../store/type';
import { CounterState } from '../../store/counter/type';

interface AppsProps {
    counter: CounterState;
}

const Header = (props: AppsProps) => {
    const { counter } = props;

    return (
        <ul>
            <li>
                <Link to="/">Apps</Link>
            </li>
            <li>
                <Link to="/home">Home</Link>
            </li>
            <li>
                <Link to="/practices">Practices</Link>
            </li>
            <li className="counter">{counter.count}</li>
        </ul>
    );
};

const mapStateToProps = ({ counter }: AppStore) => ({
    counter,
});

export default connect(mapStateToProps)(Header);
