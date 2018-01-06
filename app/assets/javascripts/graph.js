document.addEventListener("turbolinks:load", function( event ){
  var data = [1,2,3,4,5]
  $(".graph-selector-button").click(function(){
    $(".graph-selector-button").removeClass("active");
    $(this).addClass("active");
    console.log($(this).text());
    buildGraph($(this).text(), data);
  })
})

var buildGraph = function(property, data){
  console.log(property === "All");

  switch(property) {
    case "All":
      $(".student-graph").replaceWith(allGraph(data));
      break;
    case "Gender":
      $(".student-graph").replaceWith(genderGraph(data));
      break;
    case "Grade":
      $(".student-graph").replaceWith(gradeGraph(data));
      break;
    case "Pathway":
      $(".student-graph").replaceWith(pathwayGraph(data));
  }
}

var allGraph = function(data){
  return "<div class='student-graph'><h1> All </h1></div>"
}

var genderGraph = function(data){
  return "<div class='student-graph'><h1> Gender </h1></div>"
}
var gradeGraph = function(data){
  return "<div class='student-graph'><h1> Grade </h1></div>"
}

var pathwayGraph = function(data){
  return "<div class='student-graph'><h1> Pathway </h1></div>"
}
