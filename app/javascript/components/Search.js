import React from 'react';
import Autocomplete from 'react-autocomplete';
import { getStates, matchStateToTerm, sortStates, styles } from './utils'

class Search extends React.Component {
  constructor() {
    super();
    this.state = {value: ''}
  }

  render() {
    return (
      <Autocomplete
        value={this.state.value}
        inputProps={{ id: 'states-autocomplete' }}
        items={getStates()}
        getItemValue={(item) => item.name}
        onChange={(event, value) => this.setState({ value })}
        onSelect={value => this.setState({ value })}
        shouldItemRender={matchStateToTerm}
        renderItem={(item, isHighlighted) => (
          <div
            style={isHighlighted ? styles.highlightedItem : styles.item}
            key={item.abbr}
          >{item.name}</div>
        )}
      />
    )
  }
}

export default Search;
