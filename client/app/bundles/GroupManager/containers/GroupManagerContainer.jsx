import React from 'react';
import AssignUser from '../components/AssignUser';

class GroupManagerContainer extends React.Component {
  constructor() {
    super();
  }

  render() {
    return (
      <AssignUser
        buttonLabel='Assign User'
        className='modal-bg'
      />
    );
  }
}

export default GroupManagerContainer;
