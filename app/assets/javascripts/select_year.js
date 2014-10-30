$(document).ready(function(){
  var selecter = $(".select-year");

  $(selecter).change(function(){
    var select_val = $(this).val();
    location.href = "/results?season=" + select_val;
  });
});