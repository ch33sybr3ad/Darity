var eventBindings = function(){
  $('.generate').on('click', generateDare)
  $('.use-dare').on('click', useDare)
}

var generateDare = function(event){
  event.preventDefault();

  var req = $.ajax({
    url : "/generate",
    method: 'get',
    dateType: 'json',
  })

  req.done(function(response){
    var source = $('#generated-dare').html();
    var template = Handlebars.compile(source);

    $("#gen-dare").html('')
    $('#gen-dare').append(template(response));
    $('.use-dare').css('display', 'inline')
  })
}

var useDare = function(event){
  event.preventDefault();

  var dareText = $('#gen-dare li h4').text();
  $('textarea').val("I dare you to " + dareText.toLowerCase() );
}


var ready = function() {
  eventBindings();
}
$(document).ready(ready);

