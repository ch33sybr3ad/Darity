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



