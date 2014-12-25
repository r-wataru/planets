$(document).ready(function(){
  $(".goodAddOrDeleteButton").click(function(){
    var button = $(this);
    var url = location.href;
    params = url.split("/");
    var post_id = params[4];
    var comment_id = $(this).data("int");
    var user_id = $(this).data("user-int");
    $.ajax({
      url: "/posts/" + post_id + "/comments/like_add_or_delete",
      type: "POST",
      data: { like: { comment_id: comment_id, user_id: user_id }},
      success: function(json){
        span_id = "#goodCount" + comment_id;
        var good_count = parseInt($(span_id).text());
        if (json.add) {
          $(span_id).text(good_count + 1);
          button.text("いいねを取り消す");
          location.reload();
        } else {
          $(span_id).text(good_count - 1);
          button.text("いいね");
          location.reload();
        }
      },
      error: function(){
        alert("ERROR!!");
      }
    });
  });
});