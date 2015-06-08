var eventBindings = function() {
  $('.generate').on('click', generateDare);
  $('.use-dare').on('click', useDare);
};

var generateDare = function(event) {
  event.preventDefault();

  var req = $.ajax({
    url : "/generate",
    method: 'get',
    dateType: 'json',
  });

  req.done(function(response) {
    $("#gen-dare").html('<h4>'+response.description+'</h4>');
    $('.use-dare').css('display', 'inline');
  });
};

var useDare = function() {
  $('#dare_title').val("I dare you to " + $('#gen-dare h4').text().toLowerCase() );
  $('#pending_dare_title').val("I dare you to " + $('#gen-dare h4').text().toLowerCase() );
};


var ready = function() {
  eventBindings();
}
$(document).ready(ready);

