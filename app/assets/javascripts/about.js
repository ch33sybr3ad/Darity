$(document).ready(function() {

  idArray = ['#a-team', '#technology-used', '#timeline', '#conclusion']
  // idArray[0,1,2,3] 
  aCounter = 0

  $('.about-up').on('click', function(e) {
    e.preventDefault()
    if ( aCounter <= 0 ) {
      $('body').scrollTo(idArray[0])
    } else if ( aCounter === 1 ) {
      $('body').scrollTo(idArray[1])
    } else if ( aCounter >= 2 ) {
      $('body').scrollTo(idArray[2])
    };
    aCounter -= 1 
  });

  $('.about-down').on('click', function(e) {
    e.preventDefault()
    if ( aCounter <= 0 ) {
      $('body').scrollTo(idArray[1])
    } else if ( aCounter === 1 ) {
      $('body').scrollTo(idArray[2])
    } else if ( aCounter >= 2 ) {
      $('body').scrollTo(idArray[3])
    };
    aCounter += 1 
  });

});
