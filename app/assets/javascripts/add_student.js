$(document).ready(function( event ){
  console.log("add_student");
  $(".unselected-student").click(function (){
    console.log(this);
    $(this).removeClass("unselected-student");
    $(this).addClass("selected-student");
    // selectStudent(this);
  })
  // $('.selected-student').click(function (){
  //   console.log('selected clicked');
    // unselectStudent(this);
  // })
})

var selectStudent = function(thing){
  console.log(thing);
  thing.addClass("selected-student");
  thing.removeClass("unselected-student");
  // $('.selected-check-box').attr("checked", true);
}

// var unselectStudent = function(student){
//   student.addClass("unselected-student");
//   student.removeClass("selected-student");
//   $('this, selected-check-box').attr("checked", false);
// }

