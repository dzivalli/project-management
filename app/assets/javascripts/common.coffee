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
    tmp["#{obj}[username]"] = 'required'
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


  bindDatepicker = ->
    modal.find('.datepicker').datepicker
      format: 'yyyy/mm/dd'
    modal.find('.input-group-addon').on 'click',(e) ->
      e.preventDefault()
      $(this).siblings('input').datepicker('show')

  bindBootstrapSwitch = ->
    modal.find(".make-switch").bootstrapSwitch()
    elements = modal.find('.pm-price')
    if elements.length
      modal.find(".make-switch").on 'change', ->
        elements.toggle()




$(document).on 'page:load', init
$(document).ready init

