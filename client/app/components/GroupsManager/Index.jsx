import React from 'react';
import AssignUser from './components/AssignUser';

class Index extends React.Component {
  render() {
    return (
      <AssignUser
        buttonLabel='Assign User'
        className='modal-bg'
        actions={this.props.actions}
        data={this.props.data}
      />
    );
  }
}

export default Index;
