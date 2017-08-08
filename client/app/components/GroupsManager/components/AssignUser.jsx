import React from 'react';
import Search from './Search';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';

class AssignUser extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      modal: false
    };

    this.toggle = this.toggle.bind(this);
  }

  toggle() {
    this.setState({
      modal: !this.state.modal
    });
  }

  render() {
    return (
      <div>
        <Button color="primary" onClick={this.toggle}>{this.props.buttonLabel}</Button>
        <Modal isOpen={this.state.modal} toggle={this.toggle} className={this.props.className}>
          <ModalHeader toggle={this.toggle}>Assign user</ModalHeader>
          <ModalBody>
            <Search 
              current_org={this.props.current_org}
              actions={this.props.actions}
            />
          </ModalBody>
          <ModalFooter>
            <Button color="secondary" onClick={this.toggle}>Cancel</Button>{' '}
            <Button color="primary" onClick={this.toggle}>Assign</Button>
          </ModalFooter>
        </Modal>
      </div>
    );
  }
}

export default AssignUser;