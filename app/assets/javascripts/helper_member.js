$(document).ready(function() {
  if ($(".result-p-form-js").length > 0) {
    var p_select = $(".name_pitcher_selecter");
    var p_field = $(".helper_pitcher_form_field");
    var p_selected_options = $(".name_pitcher_selecter option:selected").val();
  }

  if ($(".result-b-form-js").length > 0) {
    var b_select = $(".name_batter_selecter");
    var b_field = $(".helper_batter_form_field");
    var b_selected_options = $(".name_batter_selecter option:selected").val();
  }

  window.onload = function() {
    p_display_text_field(p_selected_options, "show");
    b_display_text_field(b_selected_options, "show");
  };

  $(p_select).change(function() {
    var p_changed_selected = $(this).val();
    p_display_text_field(p_changed_selected, "change");
  });

  $(b_select).change(function() {
    var b_changed_selected = $(this).val();
    b_display_text_field(b_changed_selected, "change");
  });

  var p_display_text_field = function(selected, event) {
    if (selected === "0") {
      if (event === "show") {
        $(p_field).prop('required', true).show();
      } else {
        $(p_field).prop('required', true).slideDown(500);
      }
    } else {
      if (event === "show") {
        $(p_field).removeAttr('required').hide();
      } else {
        $(p_field).removeAttr('required').slideUp(500);
      }
    }
  };

  var b_display_text_field = function(selected, event) {
    if (selected === "0") {
      if (event === "show") {
        $(b_field).prop('required', true).show();
      } else {
        $(b_field).prop('required', true).slideDown(500);
      }
    } else {
      if (event === "show") {
        $(b_field).removeAttr('required').hide();
      } else {
        $(b_field).removeAttr('required').slideUp(500);
      }
    }
  };
});