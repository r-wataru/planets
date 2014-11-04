$(document).ready(function(){
  var check = $(".jquery_radio_box");
  var user_id = location.href.split("/")[4];

  $(check).change(function(){
    var field = $(this).attr("name");
    var value = $(this).is(":checked");
    $.ajax({
      url: "/users/" + user_id + "/update_ability",
      type: "PUT",
      data: { users: { value: value, field: field }},
      success: function(){
        console.log("OK");
      },
      error: function(){
        console.log("NG");
      }
    });
  });
});