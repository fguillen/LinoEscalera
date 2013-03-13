$(function(){
  console.log("front.js");

  // from: http://stackoverflow.com/questions/7557971/how-to-resize-rezoom-webpage-in-ipad
  $(window).bind('orientationchange', function(event) {
    if (window.orientation == 90 || window.orientation == -90 || window.orientation == 270) {
      $('meta[name="viewport"]').attr('content', 'height=device-width,width=device-height,initial-scale=1.0,maximum-scale=1.0');
      $(window).resize();
    } else {
      $('meta[name="viewport"]').attr('content', 'height=device-height,width=device-width,initial-scale=1.0,maximum-scale=1.0');
      $(window).resize();
    }
  }).trigger('orientationchange');
});