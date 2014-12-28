// 助っ人の入力Js
function PitcherBatterHelper(content) {
  var p_select = content.find(".name_pitcher_selecter");
  var p_field = content.find(".helper_pitcher_form_field");
  var p_selected_options = content.find(".name_pitcher_selecter option:selected").val();
  var b_select = content.find(".name_batter_selecter");
  var b_field = content.find(".helper_batter_form_field");
  var b_selected_options = content.find(".name_batter_selecter option:selected").val();

  window.onload = function() {
    PitcherShowField(p_selected_options, "show");
    BatterShowField(b_selected_options, "show");
  };

  p_select.on("change", function() {
    var p_changed_selected = $(this).val();
    PitcherShowField(p_changed_selected, "change");
  });

  b_select.on("change", function() {
    var b_changed_selected = $(this).val();
    BatterShowField(b_changed_selected, "change");
  });

  function PitcherShowField(selected, event) {
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
  }

  function BatterShowField(selected, event) {
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
  }
}