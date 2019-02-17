$(document).on('turbolinks:load', function() {
  $("#task_lavels").tagit({
    fieldName:"tags[]"
  });
})
