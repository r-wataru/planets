$(document).ready(function() {
  var selecting_box = $(".selecting-condition");
  var selected_box = $(".selected-condition");
  var add_button = $(".add-button");
  var remove_button = $(".remove-button");
  var user_id = location.href.split("/")[4];

  $(add_button).click(function() {
    var selecting = $(".selecting-condition option:selected");
    var selecting_val = $(selecting).val();
    var selecting_text = $(selecting).text();
    if (selecting_val !== undefined) {
      $(selecting).remove();
      $(selected_box).append($('<option>').html(selecting_text).val(selecting_val));
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
    var selected_text = $(selected).text();
    if (selected_val !== undefined) {
      $(selected).remove();
      $(selecting_box).append($('<option>').html(selected_text).val(selected_val));
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
});