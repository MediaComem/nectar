(() => {
  // NOTE: only for linter and clarity:
  /* global _ */
  /* global _jed */
  const React = window.React
  const ReactDOM = window.ReactDOM
  const Autocomplete = window.ReactAutocomplete
  React.findDOMNode = ReactDOM.findDOMNode // NOTE: autocomplete lib needs this

  window.BasicAutocomplete = window.createReactClass({
    propTypes: {
    },

    displayName: 'BasicAutocomplete',

    getInitialState () {
      return {
        term: (this.props.initialText ? this.props.initialText : ''),
        result: null
      }
    },

    _callback(result) {
      if(this.props.onChange) {
        this.props.onChange(result)
      }
    },

    _onFocus() {
      if(!this.state.result) {
        this._makeCall()
      }
    },

    _onSelect(row) {

      var term = row.label
      if(this.props.resetAfterSelection) {
        term = ''
      }

      this.setState({
        result: null,
        term: term
      })

      this._callback({
        term: row.label,
        id: row.id
      })

    },

    _onTerm(term) {
      this.setState(
        {term: term},
        this._makeCall
      )

      this._callback({
        term: term,
        id: null
      })
    },

    _makeCall() {
      this.props._makeCall(
        this.state.term,
        (result) => {
          this.setState({
              result: result
          })
        }
      )
    },

    render () {
      return (
        <BasicAutocompleteInternals
          inputClassName={this.props.inputClassName}
          element={this.props.element}
          inputId={this.props.inputId}
          dropdownWidth={this.props.dropdownWidth}
          label={this.props.label}
          term={this.state.term}
          result={this.state.result}
          _onFocus={this._onFocus}
          _onTerm={this._onTerm}
          _onSelect={this._onSelect}
          name={this.props.name}
        />
      )
    }
  })
})()