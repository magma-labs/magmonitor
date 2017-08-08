import React from 'react';
import AssignUser from './components/AssignUser';

class Index extends React.Component {
  constructor() {
    super();
  }

  render() {
    return (
      <AssignUser
        buttonLabel='Assign User'
        className='modal-bg'
        actions={this.props.actions}
      />
    );
  }
}

export default Index;
