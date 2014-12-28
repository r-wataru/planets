// 成績表の年度変更
function SelectYear() {
  var selecter = $(".select-year");
  $(selecter).change(function() {
    var select_val = $(this).val();
    location.href = "/results?season=" + select_val;
  });
}