import { createStore, combineReducers, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';

import { AppStore } from './type';
import counterStore from './counter';

const reducers = combineReducers<AppStore>({
    counter: counterStore.reducer,
});

const actions = {
    counter: counterStore.actions,
};

const store = createStore(reducers, applyMiddleware(thunk));

if (process.env.NODE_ENV !== 'production') {
    (window as any).RootStore = store.getState;
}

export default store;

export { actions };
