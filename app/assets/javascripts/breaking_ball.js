$(document).ready(function() {
  var button = $(".add-breaking-button");
  var user_id = location.href.split("/")[4];

  $(".breaking-ball-0").change(function() {
    var value = $(".breaking-ball-0 option:selected").val();
    new_form(value);
  });

  window.onload = function() {
    var value = $(".breaking-ball-0 option:selected").val();
    new_form(value);
  };

  $(".delete-breaking-button").click(function() {
    var id = $(this).data("int");
    if (confirm("Are You Sure?")) {
      $.ajax({
        url: "/users/" + user_id + "/breaking_ball_user_links/" + id,
        type: "DELETE",
        success: function() {
          console.log("OK");
          location.reload();
        },
        error: function(json) {
          console.log("NG");
        }
      });
    }
  });

  $(button).click(function() {
    var id = $(this).data("int");
    if (id === 0) {
      var selected_val = $(".breaking-ball-0 option:selected").val();
      var selected_level = $(".breaking-level-0 option:selected").val();
      if (selected_val === "0") {
        var input_val = $(".new-breaking-ball-form").val();
        new_breaking_ball_ajax(input_val, selected_level, selected_val);
      } else {
        new_ajax(selected_val, selected_level);
      }
    } else {
      var selected_val = $(".breaking-ball-" + id + " option:selected").val();
      var selected_level = $(".breaking-level-" + id + " option:selected").val();
      edit_ajax(id, selected_val, selected_level);
    }
  });

  var new_form = function(value) {
    if (value === "0") {
      $(".new-breaking-ball-form").slideDown(500);
    } else {
      $(".new-breaking-ball-form").slideUp(500);
    }
  };

  var new_ajax = function(selected_val, selected_level) {
    $.ajax({
      url: "/users/" + user_id + "/breaking_ball_user_links/",
      type: "POST",
      data: {ball: {select_value: selected_val, select_level: selected_level}},
      success: function() {
        console.log("OK");
        location.reload();
      },
      error: function() {
        console.log("NG");
      }
    });
  };

  var edit_ajax = function(id, selected_val, selected_level) {
    $.ajax({
      url: "/users/" + user_id + "/breaking_ball_user_links/" + id,
      type: "PUT",
      data: {ball: {select_value: selected_val, select_level: selected_level}},
      success: function() {
        console.log("OK");
        location.reload();
      },
      error: function() {
        console.log("NG");
      }
    });
  };

  var new_breaking_ball_ajax = function(input_val, selected_level, selected_val) {
    $.ajax({
      url: "/users/" + user_id + "/breaking_ball_user_links/create_breaking_ball",
      type: "POST",
      data: {ball: {select_value: selected_val, select_level: selected_level, value: input_val}},
      success: function(json) {
        if (json.errors === true) {
          $(".new-breaking-ball-form").addClass("has-field-error");
          $(".error-message-new-breaking-ball").text(json.error_message.name);
          alert(json.error_message.name);
        } else {
          console.log("OK");
          location.reload();
        }
      },
      error: function(json) {
        alert(json.error_message);
        console.log("NG");
      }
    });
  };
});