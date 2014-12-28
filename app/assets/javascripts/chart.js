// User詳細の能力のChart
function ChartDisplay() {
  var p_data_array = [];
  var p_array = ["shot", "meet", "power", "run", "shoulder", "defend"];
  $.each(p_array, function(i, val) {
    p_data_array.push($(".value-name-" + val).data("int"));
  });
  var b_data = {
    labels: ["弾丸", "ミート", "パワー", "走力", "肩力", "守力"],
    datasets: [{
        fillColor: "rgba(151,187,205,0.5)",
        strokeColor: "rgba(151,187,205,1)",
        pointColor: "rgba(151,187,205,1)",
        pointStrokeColor: "#fff",
        data: p_data_array
      }]
  };
  var b_canvas = document.getElementById("batterCanvas");
  var context = b_canvas.getContext("2d");
  var chart = new Chart(context);
  chart.Radar(b_data, {scaleShowLabels: false, pointLabelFontSize: 8, scaleStartValue: 0});

  var b_data_array = [];
  var b_array = ["speed", "control", "stamina"];
  $.each(b_array, function(i, val) {
    b_data_array.push($(".value-name-" + val).data("int"));
  });
  var p_data = {
    labels: ["速球", "コントロール", "スタミナ"],
    datasets: [{
        fillColor: "rgba(151,187,205,0.5)",
        strokeColor: "rgba(151,187,205,1)",
        pointColor: "rgba(151,187,205,1)",
        pointStrokeColor: "#fff",
        data: b_data_array
      }]
  };
  var p_canvas = document.getElementById("picherCanvas");
  var context = p_canvas.getContext("2d");
  var chart = new Chart(context);
  chart.Radar(p_data, {scaleShowLabels: false, pointLabelFontSize: 8, scaleStartValue: 0});
}