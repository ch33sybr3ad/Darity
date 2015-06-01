var watchForm = function() {
  $('.signup-link a').on('click', function(e){
    e.preventDefault();

    $('.login-area').hide();
    $('.signup-area').show();
  });

  $('.login-link a').on('click', function(e){
    e.preventDefault();

    $('.signup-area').hide();
    $('.login-area').show();
  });

  $('.new_user').on('submit', function(e){
    e.preventDefault();

    if ($('input#signup-password').val() === $('input#signup-password-confirm').val()) {
      $('.new_user').off('submit').submit();
    } else {
      $('.alert').show();
      $('.alert').text('Password Not Matching');
    }

  });
};

$(document).on('ready', watchForm);
