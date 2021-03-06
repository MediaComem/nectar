class window.App.ModelsShowController extends Spine.Controller

  events:
    "click [data-create-order-line]": "openBookingCalendar"

  constructor: ->
    super
    new App.ModelsShowPropertiesController {el: "#properties"}
    new App.ModelsShowImagesController {el: "#images"}

  getStartDate: =>
    if sessionStorage.startDate?.length
      moment(sessionStorage.startDate, "DD.MM.YYYY")
    else
      moment()

  getEndDate: =>
    if sessionStorage.endDate?.length
      moment(sessionStorage.endDate, "DD.MM.YYYY")
    else
      moment().add(1, "days")

  openBookingCalendar: (e)=>
    do e.preventDefault
    @renderBookingCalendar()

  renderBookingCalendar: () =>
    jModal = $("<div class='modal ui-modal medium' role='dialog' tabIndex='-1' />")
    @modal = new App.Modal(
      jModal,
      () => ReactDOM.unmountComponentAtNode(jModal.get()[0])
    )
    ReactDOM.render(
      React.createElement(CalendarDialog,
        model: @model
        inventoryPools: @inventoryPools
        initialStartDate: @getStartDate()
        initialEndDate: @getEndDate()
        finishCallback: (data) =>
          _.each(data, (reservation) => App.Reservation.addRecord(new App.Reservation(reservation)))
          App.Reservation.trigger "refresh"
          @modal.destroyable()
          App.Modal.destroyAll true
      ),
      @modal.el.get()[0]
    )
