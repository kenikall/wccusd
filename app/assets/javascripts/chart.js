var doc = new jsPDF('p', 'px', 'letter');

var options = {
        pagesplit: true,
        background: '#fff',
};

var specialElementHandlers = {
    '#print-wrapper': function (element, renderer) {
        return true;
    }
};

$(document).on("change","select",function(){
  $("option[value=" + this.value + "]", this)
  .attr("selected", true).siblings()
  .removeAttr("selected")
});

document.addEventListener("turbolinks:load", function( event ){
  $(".graph-selector-button").click(function(){
    $(".graph-selector-button").removeClass("active");
    $(this).addClass("active");
    gatherGraphData($.trim($(this).text()));
  })
})

document.addEventListener("turbolinks:load", function( event ){
  $("#school-chart-selector").on("change", function ( event ){
    updateButton();
  })

  $("#pathway-chart-selector").on("change", function ( event ){
    updateButton();
  })

  $("#grade-chart-selector").on("change", function ( event ){
    updateButton();
  })

  $('#print-chart-button').click(function () {
    doc.rect(20, 20, doc.internal.pageSize.width - 40, doc.internal.pageSize.height - 40, 'S');
    doc.addHTML($('#print-wrapper')[0], options, function () {
      doc.save('sample-file.pdf');
    });
  });
})

var updateButton = function(){
  // $("#new-chart-button").html( "<a class='btn btn-warning text-center' style='float: right;' href=" + chartPath() + ">Charts</a>");
}

var chartPath = function(){
  var path = window.location.pathname + "?";
  path += ("school=" + $("#school-chart-selector option:selected").text());
  if($("#pathway-chart-selector option:selected").text() != "All") { path += ("&pathway=" + $("#pathway-chart-selector option:selected").text());}
  if($("#grade-chart-selector").val() != "All") { path += ("&grade=" + $("#grade-chart-selector").val());}
  if($("#teacher-chart-selector").val()) { path += ("&teacher=" + $("#teacher-chart-selector").val());}

  return path;
}

