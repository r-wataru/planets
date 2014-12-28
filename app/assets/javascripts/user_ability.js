// 能力のJs
function UserAbility(content) {
  var slider = content.find(".jquery-ui-slider");
  var user_id = location.href.split("/")[4];
  var radio = content.find(".jquery_throw_button");
  var check = $(".jquery_radio_box");
  var add_button = content.find(".add-button");
  var remove_button = content.find(".remove-button");
  var new_selecting_form = content.find(".new-selecting-form-show-button");
  var add_selecting_button = content.find(".add-selecting-button");
  var breaking_button = content.find(".add-breaking-button");
  var breaking_deleted_button = content.find(".delete-breaking-button");
  var breaking_zero = content.find(".breaking-ball-0");

  UserSlider(slider);
  radio.on("change", function() {
    UserRadio($(this));
  });
  check.on("change", function() {
    UserCheckBox($(this));
  });
  add_button.on("click", function() {
    AddAttribute($(this));
  });
  remove_button.on("click", function() {
    DeleteAttribute($(this));
  });
  new_selecting_form.on("click", function() {
    var data = $(this).data("int");
    if (data === 2) {
      $(".new-selecting-form-d").slideDown(500);
    } else {
      $(".new-selecting-form-p").slideDown(500);
    }
  });
  add_selecting_button.on("click", function() {
    var data = $(this).data("str");
    if (data === "new-selectin-d") {
      var t_value = $(".new-selecting-field").val();
      var d_value = $(".new-selecting-field-d").val();
      var condition = $(".new-selecting-condition-d option:selected").val();
      NewCharactersAndLinks(user_id, "d", t_value, d_value, condition);
    } else {
      var t_value = $(".new-selecting-field-p").val();
      var d_value = $(".new-selecting-field-d-p").val();
      var condition = $(".new-selecting-condition-p option:selected").val();
      NewCharactersAndLinks(user_id, "p", t_value, d_value, condition);
    }
  });
  breaking_button.on("click", function() {
    BreakingButtonAction($(this));
  });
  breaking_zero.on("change", function() {
    var value = $(".breaking-ball-0 option:selected").val();
    NewForm(value);
  });
  window.onload = function() {
    var value = $(".breaking-ball-0 option:selected").val();
    NewForm(value);
  };
  breaking_deleted_button.on("click", function() {
    BreakingButtonDelete($(this));
  });

  //能力のチェックボックス
  function UserCheckBox(selected_box) {
    var field = selected_box.attr("name");
    var value = selected_box.is(":checked");
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

  //能力のスライダー
  function UserSlider(slider) {
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
  }

  // 能力のラジオボタン
  function UserRadio(select_this) {
    var value = select_this.val();
    var field = select_this.attr("name");
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

  // 能力の属性追加
  function AddAttribute(selected_data) {
    var selecting = $(".selecting-condition option:selected");
    var button_data = selected_data.data("int");
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
  }

  // 能力の属性削除
  function DeleteAttribute(selected_data) {
    var selected = $(".selected-condition option:selected");
    var selected_val = $(selected).val();
    var button_data = selected_data.data("int");
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
  }

  // 属性の追加
  function NewCharactersAndLinks(user_id, type, t_value, d_value, condition) {
    $.ajax({
      url: "/users/" + user_id + "/characters/create_and_links",
      type: "POST",
      data: {users: {value: t_value, description: d_value, type: type, condition: condition}},
      success: function(json) {
        if (json.success === false) {
          if (type === "p") {
            console.log(json.error_keys);
            $(".new-select-des-p").text(json.error_message.description);
            $(".new-select-name-p").text(json.error_message.name);
            if (json.error_keys.indexOf("name") >= 0) {
              $(".new-selecting-field-p").addClass("has-field-error");
            }
            if (json.error_keys.indexOf("description") >= 0) {
              $(".new-selecting-field-d-p").addClass("has-field-error");
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
  }

  // 変化球を外すajax
  function BreakingButtonDelete(selected_data) {
    var id = selected_data.data("int");
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
  }

  // 変化球の追加 or 編集
  function BreakingButtonAction(selected_data) {
    var id = selected_data.data("int");
    if (id === 0) {
      var selected_val = $(".breaking-ball-0 option:selected").val();
      var selected_level = $(".breaking-level-0 option:selected").val();
      if (selected_val === "0") {
        var input_val = $(".new-breaking-ball-form").val();
        NewBreakingBallAjax(input_val, selected_level, selected_val);
      } else {
        NewAjax(selected_val, selected_level);
      }
    } else {
      var selected_val = $(".breaking-ball-" + id + " option:selected").val();
      var selected_level = $(".breaking-level-" + id + " option:selected").val();
      EditAjax(id, selected_val, selected_level);
    }
  }

  // 変化球追加のフォーム
  function NewForm(value) {
    if (value === "0") {
      $(".new-breaking-ball-form").slideDown(500);
    } else {
      $(".new-breaking-ball-form").slideUp(500);
    }
  }

  // 変化球追加のajax
  function NewAjax(selected_val, selected_level) {
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
  }

  // 変化球更新のajax
  function EditAjax(id, selected_val, selected_level) {
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
  }

  // 変化球追加のAction
  function NewBreakingBallAjax(input_val, selected_level, selected_val) {
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
  }
}