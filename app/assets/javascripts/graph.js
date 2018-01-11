document.addEventListener("turbolinks:load", function( event ){
  $(".graph-selector-button").click(function(){
    $(".graph-selector-button").removeClass("active");
    $(this).addClass("active");
    gatherGraphData($.trim($(this).text()));
  })
})

var buildGraph = function(property, data){
  // if(property === "Gender"){
  //   $(".student-graph").html(genderGraph(data));
  // } else if(property === "Grade"){
  //   $(".student-graph").html(gradeGraph(data));
  // } else if(property === "Pathway"){
  //   $(".student-graph").html(pathwayGraph(data));
  // } else {
    $(".student-graph").html(allGraph(data));
  // }
}

var allGraph = function(data){
  return '<dl><dt>All Responses</dt>' +
    '<dd class= "percentage percentage-'+data.question1+'">'+
      '<span class="text">Question 1: '+data.question1+'%</span></dd>' +
    '<dd class= "percentage percentage-'+data.question2+'">'+
      '<span class="text">Question 2: '+data.question2+'%</span></dd>' +
    '<dd class= "percentage percentage-'+data.question3+'">'+
      '<span class="text">Question 3: '+data.question3+'%</span></dd>' +
    '<dd class= "percentage percentage-'+data.question4+'">'+
      '<span class="text">Question 4: '+data.question4+'%</span></dd>' +
    '</dl>';
}

var genderGraph = function(data){
    return '<dl><dt>Responses Sorted by Gender</dt>' +
    '<dd class= "male percentage-10">'+
    '<dd class= "female percentage-40">'+
      '<span class="text">Question 1</span></dd>' +
    '<dd class= "male percentage-10">'+
    '<dd class= "female percentage-40">'+
      '<span class="text">Question 2</span></dd>' +
    '<dd class= "male percentage-10">'+
    '<dd class= "female percentage-40">'+
      '<span class="text">Question 3</span></dd>' +
    '<dd class= "male percentage-10">'+
    '<dd class= "female percentage-40">'+
      '<span class="text">Question 4</span></dd>' +
    '</dl></div>';
}
var gradeGraph = function(data){
  return "<div class='student-graph'><h1> Grade </h1></div>"
}

var pathwayGraph = function(data){
  return "<div class='student-graph'><h1> Pathway </h1></div>"
}

var gatherGraphData = function(property){
  $.ajax({
    type: "POST",
    url: "/graph/format/",
    data: {
        event_id: window.location.href.match(/event\/(\d+)\/survey/)[1],
        property: property
    },
    success: function(result) {
      buildGraph(property, result);
    },
    error: function(result) {
      alert('error');
    }
  })
}
