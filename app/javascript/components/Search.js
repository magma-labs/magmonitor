import React from 'react';
import {Typeahead} from 'react-bootstrap-typeahead';

class Search extends React.Component {
  render() {
    return (
      <Typeahead
        labelKey="name"
        options={
          [
            {name: 'Alabama', population: 4780127, capital: 'Montgomery', region: 'South'},
            {name: 'Alaska', population: 710249, capital: 'Juneau', region: 'West'},
            {name: 'Arizona', population: 6392307, capital: 'Phoenix', region: 'West'}
          ]
        }
        placeholder="Choose a state..."
      />
    )
  }
}

export default Search;
