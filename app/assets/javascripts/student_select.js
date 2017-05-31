$(document).ready(function( event ){
  $("#filtered-students").on("click", ".unselected-student", function ( event ){
    $(this).find(".check-box").prop( "checked", true );
    $(this).removeClass("unselected-student").addClass("selected-student");
  })

  $("#filtered-students").on("click", ".selected-student", function ( event ){
    $(this).find(".check-box").prop( "checked", false );
    $(this).removeClass("selected-student").addClass("unselected-student");
  })
})


