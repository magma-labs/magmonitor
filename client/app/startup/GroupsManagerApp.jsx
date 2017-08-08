import React from 'react';
import { combineReducers, applyMiddleware, createStore } from 'redux';
import { Provider } from 'react-redux';
import thunkMiddleware from 'redux-thunk';
import { AppContainer } from "react-hot-loader";
import { render } from "react-dom";

import reducers from '../reducers/reducersIndex';
import composeInitialState from '../store/composeInitialState';

import GroupsManagerContainer from '../components/GroupsManager/GroupsManagerContainer';

export default (props, railsContext, domNodeId) => {
  const combinedReducer = combineReducers(reducers);
  const combinedProps = composeInitialState(props, railsContext);
  const store = createStore(combinedReducer, combinedProps, applyMiddleware(thunkMiddleware));

  const renderApp = (Komponent) => {
    const element = (
      <AppContainer>
        <Provider store={store}>
          <Komponent />
        </Provider>
      </AppContainer>
    )
    render(element, document.getElementById(domNodeId));
  }

  renderApp(GroupsManagerContainer);

  if (module.hot) {
    module.hot.accept(['../reducers/reducersIndex',
      '../components/GroupsManager/GroupsManagerContainer'], () => {
        store.replaceReducer(combineReducers(reducers));
        renderApp(GroupsManagerContainer);
      })
  }
};
