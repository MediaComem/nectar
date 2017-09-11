class window.App.FormWithUploadController extends Spine.Controller

  elements:
    "#form": "form"
    "#save": "saveButton"

  events:
    "click #save": "submit"
    "submit #form": "preventDefaultSubmit"

  preventDefaultSubmit: (e)=> e.preventDefault()

  submit: (event, saveAction = @save, errorHandler = @errorHandler) =>
    do @showLoading
    if result = saveAction()
      result
        .fail (e) => errorHandler(e)
        .done (data) => @done(data)

  errorHandler: (e) =>
    @showError e.responseText
    do @hideLoading

  done: => # virtual

  save: => # virtual

  showLoading: =>
    loadingTemplate = $ App.Render "views/loading", {size: "micro"}
    @saveButton.data "origin", @saveButton.html()
    @saveButton.html loadingTemplate
    @saveButton.prop "disabled", true

  hideLoading: =>
    @saveButton.html @saveButton.data "origin"
    @saveButton.prop "disabled", false

  showError: (text) =>
    App.Flash
      type: "error"
      message: text

  collectErrorMessages: => #virtual

  setupImageRestrictionsErrorModel: (entity, message) =>
    tmpl = App.Render "manage/views/templates/upload/upload_image_type_errors_dialog",
      url: entity.url("edit")
      headlineMessage: message
      buttonLabel: _jed("Edit %s", _jed(entity.constructor.name))
    modal = new App.Modal tmpl
    modal.undestroyable()

  setupErrorModal: (entity) =>
    errors = @collectErrorMessages()
    tmpl = App.Render "manage/views/templates/upload/upload_errors_dialog",
      errors: errors
      url: entity.url("edit")
      headlineMessage: _jed("%s was saved, but there were problems uploading files", _jed(entity.constructor.name))
      buttonLabel: _jed("Edit %s", _jed(entity.constructor.name))

    modal = new App.Modal tmpl
    modal.undestroyable()
