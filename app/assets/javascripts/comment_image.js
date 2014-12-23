$(document).ready(function(){
  var input = $("#comment_form_image_uploaded_image");
  input.after("<span></span>");

  // test(複数上げる場合)
  // 以下をviewに
  //<div id="testUploadImageUrl" data-str="<%= create_image_post_comments_path(@post) %>"></div>
  //<%= file_field_tag :uploaded_test_image, id: "testUploadFieldImage" %>
  var input_test = $("#testUploadFieldImage");
  input_test.change(function(){
    var fd = new FormData();
    fd.append('file', $(this)[0].files[0]);
    var url = $("#testUploadImageUrl").data("str");
    $.ajax({
      url: url,
      data: fd,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(json){
        alert(json);
      }
    });
  });

  input.change(function(){
    var file = $(this).prop('files')[0];

    // 画像以外は処理を停止
    if (! file.type.match('image.*')) {
      $('span').html('');
      return;
    }

    // 画像表示
    var reader = new FileReader();
    reader.onload = function() {
      var img_src = $('<img>').attr('src', reader.result).attr('style', 'max-width: 100%;');
      $('span').html(img_src).hide();
      $('span').slideDown(2000);
    };
    reader.readAsDataURL(file);
  });
});