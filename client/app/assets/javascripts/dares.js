$(document).ready(function(){
  eventBindings();
});

$(document).on('page:load', function(){
  eventBindings();
});


var eventBindings = function(){
  $('.generate').on('click', generateDare)
}
}

var generateDare = function(event){
  event.preventDefault();
  // debugger

  var req = $.ajax({
    url : "/generate",
    method: 'get',
    dateType: 'json',
  })

  req.done(function(response){
    var source = $('#generated-dare').html();
    var template = Handlebars.compile(source);
    // debugger

    $("#gen-dare").html('')
    $('#gen-dare').append(template(response));
    // debugger
  })

}


