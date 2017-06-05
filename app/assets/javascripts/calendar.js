document.addEventListener("turbolinks:load", function( event ){
  console.log("calendar");
  $(".day").click(function (){
    var clickedDay = this;
    console.log(clickedDay);
    if(clickedDay.hasClass(future)){
    }
  })
  $()
})
