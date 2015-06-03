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
    $("#gen-dare").html('<p>'+response.description+'</p>');
    $('.use-dare').css('display', 'inline');
  });
};

var useDare = function() {
  $('#dare_title').val("I dare you to " + $('#gen-dare p').text().toLowerCase() );
  $('#pending_dare_title').val("I dare you to " + $('#gen-dare p').text().toLowerCase() );
};


var ready = function() {
  eventBindings();
}
$(document).ready(ready);

