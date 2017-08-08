import React from 'react';
import {AsyncTypeahead} from 'react-bootstrap-typeahead';
import Request from '../../../utils/Request';

class Search extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      options: [],
      current_value: ''
    }

    this.handleSearch = this.handleSearch.bind(this);
    this.handleSelectedOption = this.handleSelectedOption.bind(this);
    this.isValidUserEmail = this.isValidUserEmail.bind(this);
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

  isValidUserEmail = (email) => {
    return this.state.options.find((user) => {return user.email === email});
  }

  handleSelectedOption = (e) => {
    const email = e.target.value;
    const currentValue = this.isValidUserEmail(email) ? email : '';
    this.setState({current_value: currentValue});
    this.props.actions.updateValue(currentValue);
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
        onBlur={this.handleSelectedOption}
      />
    )
  }
}

export default Search;
