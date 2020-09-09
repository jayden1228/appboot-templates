import { Reducer, AnyAction } from 'redux';
import { CounterState } from './type';

/* actionType 常量定义 */
export const UPDATE_COUNT = 'counter/update';

/* 默认 state */
const defaultState: CounterState = {
    count: 12,
};

/**
 * ----------------------------------
 * Reducer
 * 用于计算 state, state 更改后触发 view
 * ----------------------------------
 */

const reducer: Reducer<CounterState> = (
    state: CounterState = defaultState,
    action: AnyAction
) => {
    switch (action.type) {
        case UPDATE_COUNT:
            state = Object.assign({}, state, action.payload);
            break;
        default:
            state = defaultState;
            break;
    }
    return state;
};

/**
 * ----------------------------------
 * Actions
 * 用于触发 reducer 计算
 * ----------------------------------
 */

const actions = {
    updateCount(num: number) {
        const action: AnyAction = {
            type: UPDATE_COUNT,
            payload: {
                count: num,
            },
        };
        return action;
    },
};

export default { reducer, actions };
