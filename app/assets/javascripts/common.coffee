class @Common
  datatable:
    "sPaginationType": "bootstrap"
    "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Все"]]
    "language":
      "url": "datatable/Russian.json"
    "bStateSave": true
    fnDrawCallback: ->
      $(".dataTables_wrapper select").select2
        minimumResultsForSearch: -1

  bindSubmit: (modal, button)->
    modal.on 'click', button, ->
      modal.find('form').submit()

#  bindGetModal: (url, modalWrap, button)->
#    $(button).on 'click', ->
#      $.get url, (result) =>
#        debugger
#        modalWrap.html(result).modal('show')
#        modalWrap.find('form').validate(@common.validate)

  generateToaster: ->
    msg = $('#message')
    if msg
      opts =
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
        toastr.success msg.html(), null, opts
      else if msg.data('msg') is 'alert'
        toastr.error msg.html(), null, opts

  generateRules: (obj) ->
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

