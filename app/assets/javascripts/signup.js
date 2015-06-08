  var watchForm = function() {
    $('.new_user').on('submit', function(e){
      e.preventDefault();
      if ($(this).find('input.signup-password').val() === $(this).find('input.signup-password-confirm').val()) {
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
      var new_pw = $(this).find('[name="user[new_password]"]').val()
      var new_pw2 = $(this).find('[name="user[confirm_password]"]').val()
      debugger;
      if (!(new_pw === new_pw2)) {
        $(this).find('[name="user[new_password]"]').css("border-color", "red")
        $(this).find('[name="user[confirm_password]"]').css("border-color", "red")
      } else {
          $('.edit_user').off('submit').submit();
      };
    });
  };

$(document).ready(function() {

  watchForm();
  editForm();

  $('body').scrollspy({ target: '#navbar' })

  $('#show-signup').on('click', function(e) {
    e.preventDefault();
    $('a.dropdown-toggle.signup').dropdown('toggle');
  });

  $('#show-login').on('click', function(e) {
    e.preventDefault();
    $('a.dropdown-toggle.login').dropdown('toggle');
  });

});
