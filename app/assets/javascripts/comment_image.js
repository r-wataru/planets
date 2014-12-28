// テスト用
////$(document).ready(function() {
//  test(複数上げる場合)
//  以下をviewに
//  <div id="testUploadImageUrl" data-str="<%= create_image_post_comments_path(@post) %>"></div>
//  <%= file_field_tag :uploaded_test_image, id: "testUploadFieldImage" %>
//  var input_test = $("#testUploadFieldImage");
//  input_test.change(function() {
//    var fd = new FormData();
//    fd.append('file', $(this)[0].files[0]);
//    var url = $("#testUploadImageUrl").data("str");
//    $.ajax({
//      url: url,
//      data: fd,
//      processData: false,
//      contentType: false,
//      type: 'POST',
//      success: function(json) {
//        alert(json);
//      }
//    });
//  });
//});