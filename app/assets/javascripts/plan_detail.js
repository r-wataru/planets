// 出席表のJs
function AttendanceChange(content) {
  var selected_link = content.find(".selected_user_link");
  var delete_user = content.find(".delete_user_link");

  selected_link.on("click", function() {
    SelectUserAdd($(this));
  });
  delete_user.on("click", function() {
    SelectUserDelete($(this))
  });

  // 出欠席に追加する
  function SelectUserAdd(selected) {
    var kind = selected.data("int");
    var schedule_id = $("#planDetailUserLinkId").data("schedule-int");
    var detail_id = $("#planDetailUserLinkId").data("int");
    var selected = $("#user_detail_link option:selected");
    var selected_val = selected.val();
    if (selected_val !== undefined && detail_id !== undefined &&
            schedule_id !== undefined && kind !== undefined) {
      $.ajax({
        url: "/schedules/" + schedule_id + "/plan_details/" + detail_id + "/add_or_delete",
        type: "POST",
        data: {status: kind, user: selected_val, action_name: "create"},
        success: function(json) {
          $(selected).remove();
          if (kind === 1) {
            $("#user_detail_link_selected").append($('<option>').html(json.user_name).val(json.user_id));
          } else if (kind === 2) {
            $("#user_detail_link_absence").append($('<option>').html(json.user_name).val(json.user_id));
          } else if (kind === 3) {
            $("#user_detail_link_hold").append($('<option>').html(json.user_name).val(json.user_id));
          }
        },
        error: function() {
          alert("エラーが発生しました。")
        }
      });
    }
  }

  // 出欠席から削除
  function SelectUserDelete(selected) {
    var kind = selected.data("int");
    var schedule_id = $("#planDetailUserLinkId").data("schedule-int");
    var detail_id = $("#planDetailUserLinkId").data("int");
    if (kind === 1) {
      var selected = $("#user_detail_link_selected option:selected")
    } else if (kind === 2) {
      var selected = $("#user_detail_link_absence option:selected")
    } else if (kind === 3) {
      var selected = $("#user_detail_link_hold option:selected")
    }
    var selected_val = selected.val();
    if (selected_val !== undefined && detail_id !== undefined &&
            schedule_id !== undefined && kind !== undefined) {
      $.ajax({
        url: "/schedules/" + schedule_id + "/plan_details/" + detail_id + "/add_or_delete",
        type: "POST",
        data: {status: kind, user: selected_val, action_name: "delete"},
        success: function(json) {
          $(selected).remove();
          $("#user_detail_link").append($('<option>').html(json.user_name).val(json.user_id));
        },
        error: function() {
          alert("エラーが発生しました。")
        }
      });
    }
  }
}