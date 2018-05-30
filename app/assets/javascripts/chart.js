document.addEventListener("turbolinks:load", function( event ){
  $(".graph-selector-button").click(function(){
    $(".graph-selector-button").removeClass("active");
    $(this).addClass("active");
    gatherGraphData($.trim($(this).text()));
  })
})
