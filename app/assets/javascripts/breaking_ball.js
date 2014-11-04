$(document).ready(function(){
  var button = $(".add-breaking-button");
  var user_id = location.href.split("/")[4];

  $(button).click(function(){
    var id = $(this).data("int");

    if (id === 0) {
      var selected_val = $(".breaking-ball-0 option:selected").val();
      var selected_level = $(".breaking-level-0 option:selected").val();
      $.ajax({
        url: "/users/" + user_id + "/breaking_ball_user_links/",
        type: "POST",
        data: { ball: { select_value: selected_val, select_level: selected_level } },
        success: function(){
          console.log("OK");
        },
        error: function(){
          console.log("NG");
        }
      });
    } else {
      var selected_val = $(".breaking-ball-" + id + " option:selected").val();
      var selected_level = $(".breaking-level-" + id + " option:selected").val();
      $.ajax({
        url: "/users/" + user_id + "/breaking_ball_user_links/" + id,
        type: "PUT",
        data: { ball: { select_value: selected_val, select_level: selected_level }},
        success: function(){
          console.log("OK");
        },
        error: function(){
          console.log("NG");
        }
      });
    }
  });
});