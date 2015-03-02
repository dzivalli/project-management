# all common js function for every controller put here

init = ->

#  load datatable
  dtOpts =
    "sPaginationType": "bootstrap"
    "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Все"]]
    "language":
      "url": "/datatable/Russian.json"
    "bStateSave": true
    fnDrawCallback: ->
      $(".dataTables_wrapper select").select2
        minimumResultsForSearch: -1
  $('.pm-table').dataTable dtOpts


#  bind submit to modal
  modal = $("#new-modal")
  modal.on 'click', '#save-modal', ->
    modal.find('form').submit()

#  generate toaster message
  msg = $('#message')
  if msg.length
    toasterOpts =
      "closeButton": true
      "debug": false
      "positionClass": "toast-bottom-right"
      "onclick": null
      "showDuration": "300"
      "hideDuration": "1000"
      "timeOut": "5000"
      "extendedTimeOut": "1000"
      "showEasing": "swing"
      "hideEasing": "linear"
      "showMethod": "fadeIn"
      "hideMethod": "fadeOut"
    if msg.data('msg') is 'notice'
      toastr.success msg.html(), null, toasterOpts
    else if msg.data('msg') is 'alert'
      toastr.error msg.html(), null, toasterOpts

# generate rules for validate.js
  generateRules = (obj) ->
    tmp = {}
    tmp["#{obj}[full_name]"] = 'required'
    tmp["#{obj}[name]"] = 'required'
    tmp["#{obj}[password]"] =
      required: true
      minlength: 5
    tmp["#{obj}[password_confirmation]"] =
      required: true
      minlength: 5
      equalTo: "##{obj}_password"
    tmp["#{obj}[email]"] =
      required: true
      email: true
    tmp["#{obj}[website]"] = 'url'
    {
      rules: tmp
      errorElement: 'span'
      errorClass: 'validate-has-error'
    }

# get modal and validate required fields
  $(".get-modal").on 'click', (e) ->
    e.preventDefault()
    $.get $(this).attr('href'), (result) ->
      modal.html(result).modal('show')
      rulesFor = modal.find('form').attr('id').split("_")[1]
      modal.find('form').validate(generateRules(rulesFor))
      modal.find('select').select2
        minimumResultsForSearch: -1
      bindDatepicker()
      bindBootstrapSwitch()
      bindSlider()


  bindDatepicker = ->
    modal.find('.datepicker').datepicker
      format: 'dd-mm-yyyy'
    modal.find('.datepicker').on 'click',(e) ->
      e.preventDefault()
      $(this).siblings('input').datepicker('show')

  bindBootstrapSwitch = ->
    bSwitch = modal.find('.make-switch')
    checkbox = modal.find('[type=checkbox]')
    elements = modal.find('.pm-price')

    bSwitch.bootstrapSwitch()

    if checkbox.val() == 'true'
      bSwitch.bootstrapSwitch('setState', true)
      elements.toggle()
    else
      bSwitch.bootstrapSwitch('setState', false)

    bSwitch.on 'change', ->
      elements.toggle()
      if checkbox.val() == 'true' then checkbox.val('false') else checkbox.val('true')

  bindSlider = ->
    input = modal.find("input[id*='progress']")
    progress = input.val() || 0
    label = $("<span class='ui-label'>#{progress}</span>")
    modal.find('#slider').slider
      min: 0
      max: 100
      step: 1
      range: 'min'
      value: progress
      slide: (e, ui) ->
        label.html(ui.value)
      change: (e, ui) ->
        input.val(ui.value)
    modal.find('.ui-slider-handle').append(label)




$(document).on 'page:load', init
$(document).ready init

