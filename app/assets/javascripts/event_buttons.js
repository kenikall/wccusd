$(document).ready(function( event ){
  console.log("event buttons");
  $("#visible-student-button").on("click", "#add-visible", function( event ){
    $(".unselected-student").find(".check-box").prop( "checked", true );
    $(this).text("remove all selected");
    $(this).removeClass("btn-warning").addClass("btn-danger");
    $(this).removeAttr("id").attr("id", "remove-visible");
  })
  $("#visible-student-button").on("click", "#remove-visible",   function( event ){
    $(".unselected-student").find(".check-box").prop( "checked", false );
    $(this).removeClass("btn-danger").addClass("btn-warning");
    $(this).removeAttr("id").attr("id", "add-visible");
    var message = "add all ";
    message += ($("#select_by_grade").val() === "All") ? "students" : $("#select_by_grade").val() +" graders";
    message += ($("#select_by_school").val() === "All") ? "" : " from " + $("#select_by_school").val();
    $(this).text(message);
  })
})
