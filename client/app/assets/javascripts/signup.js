var watchForm = function() {
  $('.signup-link a').on('click', function(event){
    event.preventDefault();

    $('.login-area').hide();
    $('.signup-link').hide();
    $('.signup-area').show();
  });

  $('.login-link a').on('click', function(event){
    event.preventDefault();

    $('.signup-area').hide();
    $('.login-area').show();
    $('.signup-link').show();
  });
  $('.new_user').on('submit', function(event){
    event.preventDefault();

    if ($('input#user_password').val() === $('input#user_password_confirm').val()) {
      $.ajax({
        type: 'POST',
        url: $(this).attr('action'),
        dataType: "json",
        data: $(this).serialize()
      }).done(function(response){
        $('.new_user').off('submit').submit();
      });
    } else {
      $('invalid-sign-up').css('color', 'red')
      $('invalid-sign-up').text('Password Not Matching');
    }
  });
};

$(document).on('ready', watchForm);
$(document).on('page:load', watchForm);
