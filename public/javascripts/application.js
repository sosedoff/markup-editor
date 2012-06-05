/* -------------------------------------------------------------------------- */
/* Application Scripts */
/* -------------------------------------------------------------------------- */

var current_markup = 'markdown';
var refresh_delay = 300;
var refresh_timeout = null;

$(document).ready(function() {
  ui_calculate_window();

  $("#content").tabby({
    tabString: "  "
  });

  $("#content").scroll(function(e) {
    var pos = $(this).scrollTop();
    $("#editor_output").scrollTop(pos);
  });

  $("#editor_slider").draggable({
    axis: "x",
    containment: "parent",
    drag: ui_refresh
  });

  $(window).resize(function() {
    ui_calculate_window();
  });

  $("a.markup-switch").click(function() {
    current_markup = $(this).attr('data');
    $("a.markup-switch").removeClass('selected');
    $(this).addClass('selected');
    refresh();
  });
  
  $("a.delay-switch").click(function() {
    refresh_delay = parseInt($(this).attr('data'));
    $("a.delay-switch").removeClass('selected');
    $(this).addClass('selected');
    refresh();
  });

  $("#content").keyup(function(e) {
    if (refresh_timeout != null) {
      clearTimeout(refresh_timeout);
    }
    refresh_timeout = setTimeout(refresh, refresh_delay);
  });
  
  if ($("#content").val() != '') {
    setTimeout(refresh, 300);
  }
});

function percent_of(number, total) {
  return Math.round((number / 100) * total);
}

function refresh() {
  params = {
    content: $("#content").val(),
    markup: current_markup
  };

  $.post('/render', params, function(resp) {
    $("#output").html(resp);
  });
}

function ui_calculate_window() {
  var window_width = $(window).width();
  var window_height = $(window).height();
  var middle_height = percent_of(50, window_height - 30);
  var middle_width = percent_of(50, window_width);
  
  $("#editor_wrapper").height(window_height - 30);

  $("#editor_input").
    css('top', 30).
    css('bottom', 0).
    css('height', window_height).
    css('width', middle_width-2);

  $("#editor_slider").
    css('top', 0).
    css('bottom', 0).
    css('left', middle_width-2).
    css('height', window_height-30);

  $("#editor_output").
    css('top', 30).
    css('left', middle_width+2).
    css('right', 0).
    css('bottom',0);
  
  $("#content").width($("#editor_input").width() - 16);
  $("#content").height($("#editor_input").height() - 46);
}

function ui_refresh() {
  var pos = parseInt($("#editor_slider").css('left'));

  $("#editor_input").css('left', 0).css('width', pos-2);
  $("#editor_output").css('left', pos+2);
  $("#content").width($("#editor_input").width() - 16).height($("#editor_input").height() - 16);
}