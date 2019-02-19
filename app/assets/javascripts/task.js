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
  if (gon.tasks.length != 0　) {
    new_tasks = gon.tasks.map(x =>'『' + x + '』\n')
    new_task = new_tasks.join(',')
    window.alert(new_task + 'というタスクの期限が過ぎています！！！！')
  }
})