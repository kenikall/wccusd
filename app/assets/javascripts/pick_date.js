document.addEventListener("turbolinks:load", function( event ){
  console.log("pick_date");
  $(".day").click(function (){
    console.log(this);

  })
})
