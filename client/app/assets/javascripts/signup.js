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

var editForm = function() {
  $('.edit_user').on('submit', function(e){
    e.preventDefault();
    var email = $(this).find('[name="user[email]"]').val()
    var current_pw = $(this).find('[name="user[current_password]"]').val()
    var new_pw = $(this).find('[name="user[new_password]"]').val()
    var new_pw2 = $(this).find('[name="user[confirm_password]"]').val()
    var user_id = $(this).find('[name="user[user_id]"]').val()

    if (!(new_pw === new_pw2)) {
      $(this).find('[name="user[new_password]"]').css("border-color", "red")
      $(this).find('[name="user[confirm_password]"]').css("border-color", "red")
    } else {
      $.ajax({
        type: 'PUT',
        url: '/users/' + user_id,
        data: { user: { email: email, password: new_pw, old_password: current_password } }
      }).done(function(response) {
        console.log("success!")
        debugger
      }).fail(function(error) {
        console.log("fail!")
      });
    };
  });
}

$(document).on('ready', watchForm);
$(document).on('ready', editForm);
