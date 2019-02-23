$(document).on('turbolinks:load', function() {
  $("#task_lavels").tagit({
    fieldName:"tags[]"
  });
  if (gon.lavel_list) {
    tags = gon.lavel_list.split(",");
    for (i in tags){
       $('#task_lavels').tagit('createTag', tags[i])
     }
  };
  if (document.referrer == "http://localhost:3000/login") {
    if (gon.overtasks.length != 0　) {
      new_tasks = gon.overtasks.map(x =>'『' + x + '』\n')
      new_task = new_tasks.join(',')
      window.alert('これらのタスクの期限が過ぎています！！！！\n' + new_task)
    }
    if (gon.neartasks.length != 0 ) {
      console.log(gon.neartasks)
      new_neartasks = gon.neartasks.map(x =>'『' +  x + '』\n')
      new_neartask = new_neartasks.join(',')
      window.alert('これらのタスクの期限が迫っています！！\n' + new_neartask)
    }
  }
})