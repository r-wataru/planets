// Commentに使うJs
function CommentAction(content) {
  var good_button = content.find(".goodAddOrDeleteButton");
  var input = content.find("#comment_form_image_uploaded_image");
  good_button.on("click", function() {
    GoodOrDelete($(this));
  });
  input.on("change", function() {
    input.after("<span class='confirmImage'></span>");
    ConfirmImage($(this));
  });

  // 掲示板のいいねボタン
  function GoodOrDelete(good) {
    var link = good;
    var url = location.href;
    params = url.split("/");
    var post_id = params[4];
    var comment_id = good.data("int");
    var user_id = good.data("user-int");
    $.ajax({
      url: "/posts/" + post_id + "/comments/like_add_or_delete",
      type: "POST",
      data: {like: {comment_id: comment_id, user_id: user_id}},
      success: function(json) {
        span_id = "#goodCount" + comment_id;
        var good_count = parseInt($(span_id).text());
        if (json.add) {
          $(span_id).text(good_count + 1);
          link.text("いいねを取り消す");
          location.reload();
        } else {
          $(span_id).text(good_count - 1);
          link.text("いいね");
          location.reload();
        }
      },
      error: function() {
        alert("ERROR!!");
      }
    });
  }

  // 画像の表示
  function ConfirmImage(select_image) {
    var file = select_image.prop('files')[0];
    // 画像以外は処理を停止
    if (!file.type.match('image.*')) {
      $('span.confirmImage').html('');
      return;
    }

    // 画像表示
    var reader = new FileReader();
    if (file.size < 5242880) {
      reader.onload = function() {
        var img_src = $('<img>').attr('src', reader.result).attr('style', 'max-width: 100%;');
        $('span.confirmImage').html(img_src).hide();
        $('span.confirmImage').slideDown(1000);
      };
      reader.readAsDataURL(file);
    } else {
      alert("5MBまでです。")
    }
  }
}
