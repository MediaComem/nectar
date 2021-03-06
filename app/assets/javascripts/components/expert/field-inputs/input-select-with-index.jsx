(() => {
  // NOTE: only for linter and clarity:
  /* global _ */
  /* global _jed */
  const React = window.React
  const ReactDOM = window.ReactDOM
  const Autocomplete = window.ReactAutocomplete
  React.findDOMNode = ReactDOM.findDOMNode // NOTE: autocomplete lib needs this

  window.InputSelectWithIndex = window.createReactClass({
    propTypes: {
    },


    _onChange(event) {
      event.preventDefault()

      var l = window.lodash
      var value = l.cloneDeep(this.props.selectedValue.value)
      value.selection = this.props.selectedValue.field.values[parseInt(event.target.value)].value
      this.props.onChange(value)
    },



    _renderSelectValues(selectedValue) {
      return selectedValue.field.values.map((value, index) => {

        return (
          <option key={'' + index} value={'' + index}>
            {_jed(value.label)}
          </option>
        )
      })

    },

    render () {
      const props = this.props
      const selectedValue = props.selectedValue

      var index = - 1
      for(var i = 0; i < selectedValue.field.values.length; i++) {
        if(selectedValue.field.values[i].value === selectedValue.value.selection) {
          index = i
        }
      }

      return (
        <div className='col1of2'>
          <select className='width-full' onChange={this._onChange} value={'' + index}>
            {this._renderSelectValues(selectedValue)}
          </select>
        </div>
      )

    }
  })
})()
