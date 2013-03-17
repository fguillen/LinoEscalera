// from: http://stackoverflow.com/questions/7557971/how-to-resize-rezoom-webpage-in-ipad
$(window).bind('orientationchange', function(event) {
  console.log("orientationchange");

  var default_opts_tablet = "initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no";
  var default_opts_mobile = "user-scalable=no";

  if (window.orientation == 90 || window.orientation == -90 || window.orientation == 270) {
    $('meta[name="viewport"].tablet').attr('content', 'height=device-width,width=device-height,' + default_opts_tablet);
    $('meta[name="viewport"].mobile').attr('content', 'height=device-width,width=device-height,' + default_opts_mobile);
    $(window).resize();
  } else {
    $('meta[name="viewport"].tablet').attr('content', 'height=device-height,width=device-width,' + default_opts_tablet);
    $('meta[name="viewport"].mobile').attr('content', 'height=device-height,width=device-width,' + default_opts_mobile);
    $(window).resize();
  }
}).trigger('orientationchange');