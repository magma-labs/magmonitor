import React from 'react';
import AssignUser from './GroupsManager/AssignUser';

class AssignUserContainer extends React.Component {
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

export default AssignUserContainer;
