var searchFunction = function() {
  $("#search-bar").on('keyup', function() {
    var phrase = $(this).val();
    $.get('/users?phrase='+phrase).done(function(payload) {
      $('.user-wrap').empty();
      $('#invite-twitter').hide();
      if (payload.length > 0) {
        payload.forEach(function(user) {
          $('.user-wrap').append(
            '<p>'+user.username+
            ' <a href="/users/'+user.id+'">Dare</a>'+
            '</p>'
            );
        });
      } else {
        $('#invite-twitter').show();
        $('#handle-p').text(phrase);
        $('#handle-in').attr('value', phrase);
      }
    }).fail(function(err) {
      console.log(err);
    });
  });
};

var ready = function() {
  searchFunction();
}
$(document).ready(ready);
$(document).on('page:load', ready);
