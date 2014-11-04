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
});