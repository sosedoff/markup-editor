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

  $("#editor_slider").draggable({
    axis: "y",
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
  
  $("#editor_wrapper").height(window_height - 30);
  $("#editor_slider").css('top', middle_height);

  var offset_y = parseInt($("#editor_slider").css('top'));

  $("#editor_output").css('top', offset_y + 34).css('bottom', 0);
  $("#content").width(window_width - 16);
  $("#content").height(offset_y - 16);
}

function ui_refresh() {
  var offset_y = parseInt($("#editor_slider").css('top'));
  $("#content").height(offset_y - 16);
  $("#editor_output").css('top', offset_y + 34);
}