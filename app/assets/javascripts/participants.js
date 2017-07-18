var participantsPath = function(grade, pathway, school){
  return "/participants?grade="+grade+"&pathway="+pathway+"&school="+school
}

var participantRequest = function(grade, pathway, school){
  $.ajax({
    url: participantsPath(grade, pathway, school),
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
      +"<td><input type='checkbox' name='students[]' class='check-box' value="+students[i].i+"></td>"
      +"<td>"+students[i].first_name+" "+students[i].last_name+"</td>"
      +"<td>"+students[i].grade+"</td>"
      +"<td>"+students[i].pathway+"</td>"
      +"<td>"+students[i].school+"</td>"
     +"</tr>");
  }
}
