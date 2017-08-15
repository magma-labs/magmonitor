import React from 'react';
import Search from './Search';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';
import { isEmptyObject } from '../../../utils/common';
import Request from '../../../utils/Request';

class AssignUser extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      modal: false
    };

    this.toggle = this.toggle.bind(this);
    this.assignUser = this.assignUser.bind(this);
  }

  toggle() {
    this.setState({
      modal: !this.state.modal
    });
  }

  assignUser() {
    if (!isEmptyObject(this.props.data.user)) {
      const data = this.props.data;
      eequest.post(`/org/${this.props.current_org}/api/v1/users/assign_to_group`, {
        data: data
      }).then((response) => {
        debugger;
      });
    } else {
    }
  }

  render() {
    return (
      <div>
        <Button color="primary" onClick={this.toggle}>{this.props.buttonLabel}</Button>
        <Modal isOpen={this.state.modal} toggle={this.toggle} className={this.props.className}>
          <ModalHeader toggle={this.toggle}>Assign user</ModalHeader>
          <ModalBody>
            <Search 
              current_org={this.props.data.current_org}
              actions={this.props.actions}
            />
          </ModalBody>
          <ModalFooter>
            <Button color="secondary" onClick={this.toggle}>Cancel</Button>{' '}
            <Button color="primary" onClick={this.assignUser}>Assign</Button>
          </ModalFooter>
        </Modal>
      </div>
    );
  }
}

export default AssignUser;
