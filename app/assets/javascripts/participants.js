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
  $(".unselected-student").remove();

  for(var i = 0; i < students.length; i++){
    $("#filtered-students").append(
      "<tr class='unselected-student'>"
      +"<td><input type='checkbox' name='students[]"
      +" class='check-box' value="+students[i].id+"></td>"
      +"<td>"+students[i].first_name+" "+students[i].last_name+"</td>"
      +"<td>"+students[i].grade+"</td>"
      +"<td>"+students[i].school+"</td>"
     +"</tr>");
  }
}
