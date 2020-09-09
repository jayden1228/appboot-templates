import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import { Provider } from 'react-redux';
import store from './store';
import Apps from './components/apps/apps';
import Home from './components/home/home';
import Practices from './components/practices/practices';
import Header from './components/header/header';

export default function BasicExample() {
    return (
        <Router>
            <Provider store={store}>
                <div>
                    <Header />
                    <Switch>
                        <Route exact path="/">
                            <Apps />
                        </Route>
                        <Route exact path="/home">
                            <Home />
                        </Route>
                        <Route exact path="/practices">
                            <Practices />
                        </Route>
                    </Switch>
                </div>
            </Provider>
        </Router>
    );
}
