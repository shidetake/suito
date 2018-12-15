# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.date_picker_start').datepicker(
    dateFormat: 'yy-mm-dd'
  ).on 'change', ->
    $('.date_picker_end').datepicker("option", "minDate", $(".date_picker_start").val())
    $('.date_picker_end').datepicker("option", "defaultDate", $(".date_picker_start").val())

  $('.date_picker_end').datepicker(
    dateFormat: 'yy-mm-dd'
  )
