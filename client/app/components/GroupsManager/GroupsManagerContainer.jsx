import PropTypes from 'prop-types';
import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import Index from './Index';
import * as groupManagerActions from '../../actions/GroupsManagerActions';

const GroupsManagerContainer = ({ actions, data }) => (
  <Index {...{ actions, data }} />
);
GroupsManagerContainer.propTypes = {
  actions: PropTypes.object.isRequired,
  data: PropTypes.object.isRequired
};

function mapStateToProps(state) {
  return {
    data: state.helloWorldData
  };
}

function mapDispatchToProps(dispatch) {
  return { actions: bindActionCreators(groupManagerActions, dispatch) };
}

export default connect(mapStateToProps, mapDispatchToProps)(GroupsManagerContainer);
