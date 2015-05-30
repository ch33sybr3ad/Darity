$(document).ready(function() {

  $("#search-bar").on('keyup', function() {
    var phrase = $(this).val();
    $.get('/users?phrase='+phrase).done(function(payload) {
      $('.user-wrap').empty();
      payload.forEach(function(user) {
        $('.user-wrap').append(
          '<p>'+user.username+
            ' <a href="/users/'+user.id+'">Dare</a>'+
          '</p>'
        );
      });
    }).fail(function(err) {
      console.log(err);
    });
  });

});
