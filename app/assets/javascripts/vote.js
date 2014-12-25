$(document).ready(function(){
  $(".vote_count_button").click(function(){
    var vote_id = $(this).data("int");
    var class_name = ".vote_count" + vote_id;
    var count_num = parseInt($(class_name).text());
    var clicked_num = count_num + 1;
    $(class_name).text(clicked_num);
    $.ajax({
      type: "POST",
      url: "/votes/" + vote_id + "/update_count",
      data: { vote: { number: clicked_num }},
      success: function(json){
        $(class_name).text(json.num);
      },
      error: function(){
        alert("Has Error!!");
      }
    });
  });
});