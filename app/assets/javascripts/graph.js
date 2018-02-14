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
    '<dd class= "percentage percentage-'+data.q1percentage+'">'+
      '<span class="text">Question 1:</span></dd>' +
    '<dd class= "percentage percentage-'+data.q2percentage+'">'+
      '<span class="text">Question 2:</span></dd>' +
    '<dd class= "percentage percentage-'+data.q3percentage+'">'+
      '<span class="text">Question 3:</span></dd>' +
    '<dd class= "percentage percentage-'+data.q4percentage+'">'+
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

var tableData = function(data){
  var table = tableHead(data);
  console.log(tableHead(data));
  return table;
}

var tableHead = function(data){
  var head = "<thead><tr><th class='text-left col-md-8'></th>"
  for ( i = 0 ; i < data.length; i++ ){
    head += "<th class='text-center'>"+data[i].count+"<br>"+data[i].title+"</th>";
  }
  head += "</tr><tr>"
  for ( i = 0 ; i < data.length; i++ ){
    head += "<th class='text-center'><h4>yes / no</h4></th>";
  }
  head += "</thead>"

  return head
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
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.q1percentage+'">'+
      '<span class="text">Question 1</span></dd>' +
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.q2percentage+'">'+
      '<span class="text">Question 2</span></dd>' +
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.q3percentage+'">'+
      '<span class="text">Question 3</span></dd>' +
    '<dd class= "'+convertToClass(dataType)+' percentage-'+specificData.q4percentage+'">'+
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
