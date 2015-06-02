<<<<<<< HEAD
// var eventBindings = function(){
//   console.log("bindings");
//   // $('.approve').on('click', approveVid);
// }


$(document).ready(function() {
  $('.approve').on('click', function(event){
    event.preventDefault();
    var dareId = $('.approve').attr('href');
    var url = "/dares/" + dareId + "/donations/approve"

    var request = $.ajax({
      url: url,
      method: 'PATCH',
      data: {id: dareId},
    })

    request.done(function(response){
      $('.approve').css('background-color', 'green')
      $('.disapprove').css('background-color', 'inherit')
      $('.approve').text('Approved!')
      $('.disapprove').text('Disapprove Dare vid as Pledger!')
    })

    request.failure(function(response){
      alert("failed!")
    })

  })

  $('.disapprove').on('click', function(event){
    event.preventDefault();
    var dareId = $('.disapprove').attr('href');
    var url = "/dares/" + dareId + "/donations/disapprove"

    var request = $.ajax({
      url: url,
      method: 'PATCH',
      data: {id: dareId},
    })

    request.done(function(response){
      $('.disapprove').css('background-color', 'red')
      $('.approve').css('background-color', 'inherit')
      $('.approve').text("Approve Dare vid as Pledger!")
      $('.disapprove').text('Voted against the Dare Vid!')
    })

    request.failure(function(response){
      alert("voted against!")
    })

  })


})


// var approveVid = function(event){
//   event.preventDefault();
//   debugger
// }



=======
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
      debugger
      console.log(response);
      $('.comment-list').prepend('<li>' +response.comment.body+ " " +response.comment.likes+ " " + response.username + "</li>")
    }).fail(function(){
      console.log('fail'); 
    })
  });
})

>>>>>>> master
