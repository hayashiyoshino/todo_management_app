$(document).on('turbolinks:load', function() {
  $("#task_lavels").tagit({
    fieldName:"tags[]"
  });
  if (gon.lavel_list) {
    tags = gon.lavel_list.split(",");
    for (i in tags){
       $('#task_lavels').tagit('createTag', tags[i])
     }
  }
})
