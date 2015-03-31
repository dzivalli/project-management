# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init = ->
  $('.slider').on 'slidechange', ->
    id = $(this).slider('value')
    $('.tile-stats .num').addClass('hide')
    $("[data-id='#{id}'").removeClass('hide')
    link = $('.pm-tile a')
    url = link.attr('href').replace(/\d/, id)
    link.attr('href', url)


$(document).ready init
$(document).on 'page:load', init