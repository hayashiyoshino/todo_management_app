# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'turbolinks:load', ->
  $('#task_lavels').tagit()
  lavel_string = $("#lavel_hidden").val()
  lavel_list = lavel_string.split(',')

  $('#task_lavels').tagit("assignedTags")


