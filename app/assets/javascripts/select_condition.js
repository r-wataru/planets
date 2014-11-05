$(document).ready(function() {
  var add_button = $(".add-button");
  var remove_button = $(".remove-button");
  var user_id = location.href.split("/")[4];

  $(add_button).click(function() {
    var selecting = $(".selecting-condition option:selected");
    var button_data = $(this).data("int");
    var selecting_val = $(selecting).val();
    var selecting_text = $(selecting).text();
    if (selecting_val !== undefined) {
      $(selecting).remove();
      if (button_data === 1) {
        $(".selected-defense").append($('<option>').html(selecting_text).val(selecting_val));
      } else {
        $(".selected-pitcher").append($('<option>').html(selecting_text).val(selecting_val));
      }
      $.ajax({
        url: "/users/" + user_id + "/characters/" + selecting_val,
        type: "PUT",
        success: function() {
          console.log("OK");
        },
        error: function() {
          console.log("NG");
        }
      });
    }
  });

  $(remove_button).click(function() {
    var selected = $(".selected-condition option:selected");
    var selected_val = $(selected).val();
    var button_data = $(this).data("int");
    var selected_text = $(selected).text();
    if (selected_val !== undefined) {
      $(selected).remove();
      if (button_data === 1) {
        $(".selecting-defense").append($('<option>').html(selected_text).val(selected_val));
      } else {
        $(".selecting-pitcher").append($('<option>').html(selected_text).val(selected_val));
      }
      $.ajax({
        url: "/users/" + user_id + "/characters/" + selected_val,
        type: "DELETE",
        success: function() {
          console.log("OK");
        },
        error: function() {
          console.log("NG");
        }
      });
    }
  });

  $(".new-selecting-form-show-button").click(function() {
    var data = $(this).data("int")
    if (data === 2) {
      $(".new-selecting-form-d").slideDown(500);
    } else {
      $(".new-selecting-form-p").slideDown(500);
    }
  });

  $(".add-selecting-button").click(function() {
    var data = $(this).data("str");
    if (data === "new-selectin-d") {
      var t_value = $(".new-selecting-field").val();
      var d_value = $(".new-selecting-field-d").val();
      var condition = $(".new-selecting-condition-d option:selected").val();
      new_characters_and_links(user_id, "d", t_value, d_value, condition);
    } else {
      var t_value = $(".new-selecting-field-p").val();
      var d_value = $(".new-selecting-field-d-p").val();
      var condition = $(".new-selecting-condition-p option:selected").val();
      new_characters_and_links(user_id, "p", t_value, d_value, condition);
    }
  });

  var new_characters_and_links = function(user_id, type, t_value, d_value, condition) {
    $.ajax({
      url: "/users/" + user_id + "/characters/create_and_links",
      type: "POST",
      data: {users: {value: t_value, description: d_value, type: type, condition: condition}},
      success: function(json) {
        if (json.success === false) {
          if (type === "p") {
            console.log(json.error_keys)
            $(".new-select-des-p").text(json.error_message.description);
            $(".new-select-name-p").text(json.error_message.name);
            if (json.error_keys.indexOf("name") >= 0) {
              $(".new-selecting-field-p").addClass("has-field-error")
            }
            if (json.error_keys.indexOf("description") >= 0) {
              $(".new-selecting-field-d-p").addClass("has-field-error")
            }
          } else {
            $(".new-select-des-d").text(json.error_message.description);
            $(".new-select-name-d").text(json.error_message.name);
            if (json.error_keys.indexOf("name") >= 0) {
              $(".new-selecting-field").addClass("has-field-error")
            }
            if (json.error_keys.indexOf("description") >= 0) {
              $(".new-selecting-field-d").addClass("has-field-error")
            }
          }
        } else {
          console.log("OK");
          location.reload();
        }
      },
      error: function() {
        console.log("NG");
      }
    });
  };
});