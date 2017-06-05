document.addEventListener("turbolinks:load", function( event ){
  $("#visible-student-button").on("click", "#add-visible", function( event ){
    $(".unselected-student").find(".check-box").prop( "checked", true );
    $(".unselected-student").removeClass("unselected-student").addClass("selected-student");
    $(this).text("remove all selected");
    $(this).removeClass("btn-warning").addClass("btn-danger");
    $(this).removeAttr("id").attr("id", "remove-visible");
  })
  $("#visible-student-button").on("click", "#remove-visible",   function( event ){
    $(".selected-student").find(".check-box").prop( "checked", false );
    $(".selected-student").removeClass("selected-student").addClass("unselected-student");
    makeAddButton();
  })
  $("#select_by_grade").change(function(event){
    makeAddButton();
    participantRequest($("#select_by_grade").val(), $("#select_by_school").val())
  })

  $("#select_by_school").change(function(event){
    makeAddButton();
    participantRequest($("#select_by_grade").val(), $("#select_by_school").val())
  })
})

var makeAddButton = function(){
  $("#remove-visible").removeClass("btn-danger").addClass("btn-warning");
  $("#remove-visible").removeAttr("id").attr("id", "add-visible");
  addButtonMessage();
}

var addButtonMessage = function(){
    var message = "add all ";
    message += ($("#select_by_grade").val() === "All") ? "students" : $("#select_by_grade").val() +" graders";
    message += ($("#select_by_school").val() === "All") ? "" : " from " + $("#select_by_school").val();
    $("#add-visible").text(message);
}
