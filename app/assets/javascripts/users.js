setTimeout(function() {
  $('.notice').fadeOut();
}, 3000);

var checkTwitterHandle = function(handle) {
  return $.get('/check_handle/' + handle);
}

var searchFunction = function() {

  var searchPage = function() {
    var phrase = $(this).val();
    $('#invalid').hide();
    $.get('/users?phrase='+phrase).done(function(payload) {
      $('.user-wrap').empty();
      $('#invite-twitter').hide();
      if (payload.length > 0) {
        payload.forEach(function(user) {
          $('.user-wrap').append(
            '<li class="list-group-item user-partial">'+
            '<img src="'+user.image_url+'">'+
            ' <a href="/users/'+user.id+'">'+user.username+'</a>'+
            '</li>'
          );
        });
      } else {
        $('.user-wrap').append("<p>We don't have this user. Invite them on twitter by typing their twitter handle!");
        $('#invite-twitter').show();
        $('#handle-p').text('@' + phrase);
        $('#handle-in').attr('value', phrase);
      }
    }).fail(function(err) {
      console.log(err);
    });
  };

  var searchBar = function() {
    var phrase = $(this).val();
    $.get('/users?phrase='+phrase).done(function(payload) {
      $('#user-find li:not(:first-child)').remove();
      if (payload.length > 0) {
        payload.slice(0, 6).forEach(function(user) {
          $('#user-find').append(
            '<li><a href="/users/'+user.id+'">'+user.username+'</a></li>'
          );
        });
      } else {
        checkTwitterHandle(phrase).done(function(bool) {
          $('#user-find li:not(:first-child)').remove();
          if (bool) {
            $('#user-find').append(
              '<li><a href="/users/invite/'+phrase+'"> Invite '+phrase+' on Twitter</a></li>'
            );
          } else {
            $('#user-find').append(
              '<li>not found</li>'
            );
          }
        });
      }
    }).fail(function(err) {
      console.log(err);
    });
  };

  $("#search-bar").on('keyup', searchPage);
  $("#search-bar").on('change', searchPage);

  $("#user-search").on('keyup', searchBar);
  $("#user-search").on('change', searchBar);
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

var setActiveTab = function(tab) {
  $('.nav-tabs li').removeClass('active');
  tab.parent().addClass('active');
};

var tabs = function() {
  $('#challenged').on('click', function(e) {
    e.preventDefault();
    setActiveTab($(this));
    $.routes.find('challenged').routeTo();
  });
  $('#proposed').on('click', function(e) {
    e.preventDefault();
    setActiveTab($(this));
    $.routes.find('proposed').routeTo();
  });
  $('#pledged').on('click', function(e) {
    e.preventDefault();
    setActiveTab($(this));
    $.routes.find('pledged').routeTo();
  });
  $('#challenged').click();
};

var prepareSearch = function() {
  $('#search-bar').trigger("keyup");
  $('#search-bar').parents('form').on('submit', function(e){
    e.preventDefault();
  });
};


var ready = function() {
  searchFunction();
  dareForm();
  tabs();
  prepareSearch();
}

$(document).ready(ready);
