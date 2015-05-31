var checkTwitterHandle = function(handle) {
  return $.get('/check_handle/' + handle);
}

var searchFunction = function() {
  $("#search-bar").on('keyup', function() {
    var phrase = $(this).val();
    $('#invalid').hide();
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

var dareForm = function() {
  $('#new_pending_dare').on('submit', function(e) {
    e.preventDefault();
    var handle = $(this).find('#handle-in').val();
    checkTwitterHandle(handle).done(function(bool) {
      if (bool) {
        $('#new_pending_dare').off('submit').submit();
      } else {
        $('#invalid').show();
      }
    });
  });
}

var ready = function() {
  searchFunction();
  dareForm();
}

$(document).ready(ready);
$(document).on('page:load', ready);
