$(document).ready(function(){
  $('.new_comment').on('submit', function(e){
    e.preventDefault();
    var commentText = $(this).find('textarea').val()
    var userId = $(this).find('[name="comment[user_id]"]').val()
    var dareId = $(this).find('[name="comment[dare_id]"]').val()

    var request = $.ajax({
      url: '/comments', 
      method: 'POST', 
      data: { comment: { body: commentText, user_id: Number(userId), dare_id: Number(dareId) } }
    })

    request.done(function(response){
      console.log(response); 
      console.log("success"); 
      debugger
    }).fail(function(){
      console.log('fail'); 
    })



  });
})