window.FieldSwitch = {



  _hasValue(selectedValue, queryMode) {
    switch(selectedValue.field.type) {
      case 'text':
        if(selectedValue.field.currency && queryMode) {
          return (selectedValue.value.from.trim().length > 0 && selectedValue.value.to.trim().length > 0)
        } else {
          return selectedValue.value.text.trim().length > 0
        }
        break
      case 'autocomplete-search':
        return selectedValue.value.id != null
        break
      case 'autocomplete':
        return selectedValue.value.id != null
        break
      case 'textarea':
        return selectedValue.value.text.trim().length > 0
        break
      case 'select':
        return true
        break
      case 'radio':
        return true
        break
      case 'date':
        if(queryMode) {
          return selectedValue.value.from.trim().length > 0 && selectedValue.value.to.trim().length > 0
        } else {
          return selectedValue.value.at.trim().length > 0
        }
        break
      default:
        throw 'Unexpected type: ' + field.type
    }
  },

  _createEmptyValue (field, queryMode) {
    switch(field.type) {
      case 'text':
        if(field.currency && queryMode) {
          return {from: '', to: ''}
        } else {
          return {text: ''}
        }
        break
      case 'autocomplete-search':
        return {
          text: '',
          id: null
        }
        break
      case 'autocomplete':
        return {
          text: '',
          id: null
        }
        break
      case 'textarea':
        return {text: ''}
        break
      case 'attachment':
        break
      case 'select':
        return {selection: field.default}
        break
      case 'radio':
        return {selection: field.default}
        break
      case 'date':
        if(queryMode) {
          return {from: '', to: ''}
        } else {
          return {at: ''}
        }
        break
      default:
        throw 'Unexpected type: ' + field.type
    }
  },

  _isDependencyValue(selectedValue, fieldDependencyValue, queryMode) {
    switch(selectedValue.field.type) {
      case 'text':
        if(selectedValue.field.currency && queryMode) {
          throw 'Not implemented yet.'
        } else {
          return selectedValue.value.text == fieldDependencyValue
        }
        break
      case 'autocomplete-search':
        return selectedValue.value.text == fieldDependencyValue
        break
      case 'autocomplete':
        return selectedValue.value.id == fieldDependencyValue
        break
      case 'textarea':
        return selectedValue.value.text == fieldDependencyValue
        break
      case 'select':
        return '' + selectedValue.value.selection == fieldDependencyValue
        break
      case 'radio':
        return '' + selectedValue.value.selection == fieldDependencyValue
        break
      case 'date':
        throw 'Not implemented yet.'
        break
      default:
        throw 'Unexpected type: ' + field.type
    }
  },

  _inputByType (selectedValue, onChangeSelectedValue, dependencyValue, queryMode) {
    switch(selectedValue.field.type) {
      case 'text':
        if(selectedValue.field.currency && queryMode) {
          return <InputCurrency selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        } else {
          return <InputText selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        }
        break
      case 'autocomplete-search':
        return <InputAutocompleteSearch onChange={onChangeSelectedValue} selectedValue={selectedValue} />
        break
      case 'autocomplete':
        return <InputAutocomplete selectedValue={selectedValue} dependencyValue={dependencyValue} onChange={onChangeSelectedValue} />
        break
      case 'textarea':
        return <InputTextarea selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        break
      case 'select':
        return <InputSelectWithIndex selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        break
      case 'radio':
        return <InputRadio selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        break
      case 'date':
        if(queryMode) {
          return <InputDateRange selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        } else {
          return <InputDate selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        }
        break
      default:
        throw 'Unexpected type: ' + selectedValue.field.type
    }
  }





}
