$(document).ready(function() {
  var slider = $(".jquery-ui-slider");
  var user_id = location.href.split("/")[4];

  slider.slider({
    animate: 'slow',
    range: 'min',
    min: 0,
    max: 100,
    slide: function(event, ui) {
      var int = $(this).data("int");
      $('#jquery-ui-slider-value-' + int).val(ui.value);
    },
    create: function(event, ui) {
      var int = $(this).data("int");
      var v = $("#jquery-ui-slider-value-" + int).val();
      $(this).slider({value: v});
    },
    stop: function(event, ui) {
      var int = $(this).data("int");
      var value = ui.value;
      var field = $("#jquery-ui-slider-value-" + int).attr("name");
      $.ajax({
        url: "/users/" + user_id + "/update_ability",
        type: "PUT",
        data: {users: {value: value, field: field}},
        success: function() {
          console.log("OK");
        },
        error: function() {
          console.log("NG");
        }
      });
    }
  });
});
