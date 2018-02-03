document.addEventListener("turbolinks:load", function( event ){
  $(".graph-selector-button").click(function(){
    $(".graph-selector-button").removeClass("active");
    $(this).addClass("active");
    gatherGraphData($.trim($(this).text()));
  })
})

var buildGraph = function(property, data){
  if(property === "Gender"){
    $(".student-graph").html(graphData(data));
  } else if(property === "Grade"){
    $(".student-graph").html(graphData(data));
  } else if(property === "Ethnicity"){
    $(".student-graph").html(graphData(data));
  } else if(property === "Pathway"){
    $(".student-graph").html(graphData(data));
  } else {
    $(".student-graph").html(allGraph(data));
  }
}

var allGraph = function(data){
  return '<dl><dt>All Responses</dt>' +
    '<dd class= "percentage percentage-'+data.question1+'">'+
      '<span class="text">Question 1:</span></dd>' +
    '<dd class= "percentage percentage-'+data.question2+'">'+
      '<span class="text">Question 2:</span></dd>' +
    '<dd class= "percentage percentage-'+data.question3+'">'+
      '<span class="text">Question 3:</span></dd>' +
    '<dd class= "percentage percentage-'+data.question4+'">'+
      '<span class="text">Question 4:</span></dd>' +
    '</dl>';
}

var graphData = function(data){
  var graphFormat = ""
  for ( i = 0 ; i < data.length; i++ ){
    if (data[i].count > 0) { graphFormat += renderGraph(data[i],  data[i].title); }
  }
  return graphFormat + '</div>';
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

var renderGraph = function(specificData, dataType){
  return'<dl><dt class="subtitle">'+specificData.count+
    ' responses from '+titleCase(dataType)+' students</dt>' +
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.question1+'">'+
      '<span class="text">Question 1</span></dd>' +
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.question2+'">'+
      '<span class="text">Question 2</span></dd>' +
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.question3+'">'+
      '<span class="text">Question 3</span></dd>' +
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.question4+'">'+
      '<span class="text">Question 4</span></dd>' +
    '</dl>';
}

function titleCase(string)
{
  return string.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}

function convertToClass(string)
{
    return string.toLowerCase().replace(/ /g,'-').replace(/\//g,'-');
}
