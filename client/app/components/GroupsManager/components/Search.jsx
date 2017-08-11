import React from 'react';
import {AsyncTypeahead} from 'react-bootstrap-typeahead';
import Request from '../../../utils/Request';

class Search extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      options: [],
      currentValue: ''
    }

    this.handleSearch = this.handleSearch.bind(this);
    this.handleSelectedOption = this.handleSelectedOption.bind(this);
  }

  componentDidMount() {
    Request.get('/api/v1/current_org', {})
      .then((response) => {
        this.props.actions.setCurrentOrg(response.data.attributes.slug);
      });
  }

  parseResults(results) {
    return results.map(function(user) {
      return {
        id: user.id,
        name: user.attributes.name,
        email: user.attributes.email,
        image: user.attributes.image
      };
    });
  }

  renderMenuItemChildren(option, props, index) {
    return (
      <div key={option.id}>
        <img
          src={option.image}
          style={{
            height: '24px',
            marginRight: '10px',
            width: '24px',
          }}
        />
        <span>{`${option.email} - ${option.name}`}</span>
      </div>
    );
  }

  handleSelectedOption = (selectedUsers) => {
    let currentUser = {};
    if(selectedUsers.length > 0) {
      currentUser = selectedUsers[0];
    }
    this.props.actions.updateUser(currentUser);
  }

   handleSearch = query => {
    if (!query) {
      return;
    }

    Request.get(`/org/${this.props.current_org}/api/v1/users/autocomplete?keyword=${query}`, {})
       .then((response) => {
         this.setState({options: this.parseResults(response.data)});
       });
  }

  render() {
    return (
      <AsyncTypeahead
        {...this.state}
        labelKey={option => `${option.email} - ${option.name}`}
        onSearch={this.handleSearch}
        placeholder="Search a user..."
        renderMenuItemChildren={this.renderMenuItemChildren}
        onChange={this.handleSelectedOption}
        ref={ref => this._typeahead = ref}
      />
    )
  }
}

export default Search;
