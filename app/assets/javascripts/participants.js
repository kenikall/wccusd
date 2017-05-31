var participantsPath = function(grade, school){
  return "/participants?grade="+grade+"&school="+school
}

var participantRequest = function(grade, school){
  $.ajax({
    url: participantsPath(grade, school),
    type: 'GET',
    dataType: 'json',
    success: function(students) {
      suggestStudents(students);
    }
  })
}

var suggestStudents = function(students){
  console.log("students:");
  console.log(students);
  $(".unselected-student").remove();

  for(var i = 0; i < students.length; i++){
    $("#filtered-students").append(
      "<tr class='unselected-student'>"
      +"<td><input type='checkbox' name='selected' class='check-box'></td>"
      +"<td>"+students[i].first_name+" "+students[i].last_name+"</td>"
      +"<td>"+students[i].grade+"</td>"
      +"<td>"+students[i].school+"</td>"
      +"<input type='hidden' value="+students[i].id+" name='students[]'>"
     +"</tr>");
  }
}
