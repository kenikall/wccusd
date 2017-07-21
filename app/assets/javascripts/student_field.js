document.addEventListener("turbolinks:load", function( event ){
  $("#add-student-button").on("click", ".unselected-student", function ( event ){
    if $("add-student-field").hasClass("hidden"){
      $("add-student-field").slideToggle();
    }
    $("submit-student-field").slideToggle();
  })
})
