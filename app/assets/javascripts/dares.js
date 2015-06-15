$(document).ready(function() {
  $('.approve').on('click', function(event) {
    event.preventDefault();
    var url = $('.approve').attr('href');

    var request = $.ajax({
      url: url,
      method: 'PATCH',
    });

    request.done(function(response) {
      $('.approve').css('background-color', 'green');
      $('.disapprove').css('background-color', 'inherit');
      $('.approve').text('Approved!');
      $('.disapprove').text('Disapprove Dare vid as Pledger!');
    });

    request.failure(function(response) {
      alert("failed!");
    });

  });

  $('.disapprove').on('click', function(event) {
    event.preventDefault();
    var url = $('.disapprove').attr('href');

    var request = $.ajax({
      url: url,
      method: 'PATCH',
    });

    request.done(function(response) {
      $('.disapprove').css('background-color', 'red');
      $('.approve').css('background-color', 'inherit');
      $('.approve').text("Approve Dare vid as Pledger!");
      $('.disapprove').text('Voted against the Dare Vid!');
    });

    request.fail(function(response){
      alert("voted against!")
    })
  })
});


$(document).ready(function() {


  var source = $('#new-dare-comment').html();
  var template = Handlebars.compile(source);

  $('.new_comment').on('submit', function(e) {
    e.preventDefault();
    var commentText = $(this).find('textarea').val();
    var userId = $(this).find('[name="comment[user_id]"]').val();
    var dareId = $(this).find('[name="comment[dare_id]"]').val();

    var request = $.ajax({
      url: '/comments',
      method: 'POST',
      data: { comment: { body: commentText, author_id: Number(userId), dare_id: Number(dareId) } }
    })

    request.done(function(response) {
      $('.comment-list').prepend(template(response));
      $('#comment_body').val('');
    }).fail(function() {
      console.log('fail');
    });
  });


  $('.comment-list').on('click', 'a', function(event) {
    event.preventDefault();
    var current = $(this);
    var likeId = current.attr("href").match(/\d+/)[0]

    $.ajax({
      url: current.attr("href"),
      method: 'POST',
      data: { like: { id: likeId } }
    }).done(function(response){
      this.parent().find('span').text(response.likes_count)
    }.bind(current)).fail(function(error){
      console.log("uh oh error")
    });

  });

});
