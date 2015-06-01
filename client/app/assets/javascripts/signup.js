$(document).ready(function(){
  $('.signup-link a').on('click', function(event){
    event.preventDefault();

    $('.login-area').fadeOut();
    $('.signup-area').fadeIn();
  });

  $('.login-link a').on('click', function(event){
    event.preventDefault();

    $('.signup-area').fadeOut();
    $('.login-area').fadeIn();
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
});
