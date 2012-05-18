$(document).ready(function() {
  $('#socialbookmarts a').hover(function() {
    $(this).find('img').animate({ opacity: 0 });
  }, function() {
    $(this).find('img').animate({ opacity: 1 });
  });
});
