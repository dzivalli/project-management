# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init = ->
  $('#companies-table').dataTable
    "sPaginationType": "bootstrap"
    "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
    "bStateSave": true

  $(".dataTables_wrapper select").select2
    minimumResultsForSearch: -1

  $("#new-company").on 'click', ->
    $("#company-new-modal").modal('show')

  $("#company-save").on 'click', ->
    $("#company-new-modal form").submit()

$(document).on 'page:load', init
$(document).ready init