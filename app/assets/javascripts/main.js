$(document).on("ready page:load", function () {
  var content = $("#page-content-wrapper");
  var func_name = content.data("javascript");
  if(func_name && window[func_name]) window[func_name](content);
});
