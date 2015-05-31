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

var daresModule = {
  challenged: function() {
    $.get(window.location.pathname + '?dare_type=challenged').done(function(page) {
      $('#view-dares').html(page);
    });
  },
  proposed: function() {
    $.get(window.location.pathname + '?dare_type=proposed').done(function(page) {
      $('#view-dares').html(page);
    });
  },
  pledged: function() {
    $.get(window.location.pathname + '?dare_type=pledged').done(function(page) {
      $('#view-dares').html(page);
    });
  },
};

$.routes.add('/challenged', 'challenged', daresModule.challenged);
$.routes.add('/proposed', 'proposed', daresModule.proposed);
$.routes.add('/pledged', 'pledged', daresModule.pledged);

var tabs = function() {
  $('#challenged').on('click', function(e) {
    e.preventDefault();
    $.routes.find('challenged').routeTo();
  });
  $('#proposed').on('click', function(e) {
    e.preventDefault();
    $.routes.find('proposed').routeTo();
  });
  $('#pledged').on('click', function(e) {
    e.preventDefault();
    $.routes.find('pledged').routeTo();
  });
};

var ready = function() {
  searchFunction();
  dareForm();
  tabs();
}

$(document).ready(ready);
$(document).on('page:load', ready);
