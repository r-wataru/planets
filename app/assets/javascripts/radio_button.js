$(document).ready(function(){
  var radio = $(".jquery_throw_button");
  var user_id = location.href.split("/")[4];
  
  $(radio).change(function(){
    var value = $(this).val();
    var field = $(this).attr("name");
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