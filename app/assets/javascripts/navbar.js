var ready;
ready = function() {
  $('#main-menu-toggle i.fa-caret-right').css('visibility', 'hidden');
  $("#main-menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
    if ($("#wrapper").hasClass("toggled")) {
      $('#main-menu-toggle i.fa-caret-left').css('visibility', 'hidden');
      $('#main-menu-toggle i.fa-caret-right').css('visibility', 'visible');
    } else {
      $('#main-menu-toggle i.fa-caret-left').css('visibility', 'visible');
      $('#main-menu-toggle i.fa-caret-right').css('visibility', 'hidden');
    }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
