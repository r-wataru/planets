$(document).ready(function() {
  if ($(".result-form-js").length > 0) {
    var select = $(".name_selecter");
    var field = $(".helper_form_field");
    var selected_options = $(".name_selecter option:selected").val();

    window.onload = function() {
      display_text_field(selected_options, "show");
    };

    $(select).change(function() {
      var changed_selected = $(this).val();
      display_text_field(changed_selected, "change");
    });

    var display_text_field = function(selected, event) {
      if (selected === "0") {
        if (event === "show") {
          $(field).show();
        } else {
          $(field).slideDown(500);
        }
      } else {
        if (event === "show") {
          $(field).hide();
        } else {
          $(field).slideUp(500);
        }
      }
    };
  }
});