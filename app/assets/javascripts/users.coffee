# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init = ->
  $('#users-table').dataTable
    "sPaginationType": "bootstrap"
    "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
    "bStateSave": true

  $(".dataTables_wrapper select").select2
    minimumResultsForSearch: -1

  $("#new-user").on 'click', ->
    $("#user-new-modal").modal('show')

  $("#user-save").on 'click', ->
    $("#user-new-modal form").submit()

$(document).on 'page:load', init
$(document).ready init