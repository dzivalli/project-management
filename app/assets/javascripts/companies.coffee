# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
lib = new @Common
init = ->
  $('#companies-table').dataTable lib.datatable

  modal = $("#company-new-modal")

  $(".get-modal").on 'click', (e) ->
    e.preventDefault()
    $.get $(this).attr('href'), (result) ->
      modal.html(result).modal('show')
      modal.find('form').validate(lib.generateRules('company'))

  lib.bindSubmit(modal, "#company-save")

$(document).on 'page:load', init
$(document).ready init