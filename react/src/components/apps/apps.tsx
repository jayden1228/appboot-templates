import React from 'react';
import { Dispatch } from 'redux';
import { connect } from 'react-redux';
import { AppStore } from '../../store/type';
import { CounterState } from '../../store/counter/type';
import { actions } from '../../store';

interface AppsProps {
    counter: CounterState;
    updateCount: (num: number) => {};
}

const Apps = (props: AppsProps) => {
    const { counter, updateCount } = props;

    const clickHandler = () => {
        let count = counter.count + 1;
        updateCount(count);
    };

    return (
        <div>
            <h2>Apps</h2>
            <button onClick={clickHandler}>click me</button>
        </div>
    );
};

const mapStateToProps = ({ counter }: AppStore) => ({
    counter,
});

const mapDispatchToProps = (dispatch: Dispatch) => ({
    updateCount: (num: number) => dispatch(actions.counter.updateCount(num)),
});

export default connect(mapStateToProps, mapDispatchToProps)(Apps);
