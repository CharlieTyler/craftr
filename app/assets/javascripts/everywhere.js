$( document ).on('turbolinks:load', function() { 
  $(function() {
    $('.search-toggle').click(function() {
      $('.search-show-hide').toggle();
      $('.search-box').focus();
      $('.fa-search').toggleClass('fa-times');


    });
  });
});

$( document ).on('turbolinks:load', function() { 
  $(function() {
    $('.top-nav-carousel').owlCarousel({
      loop:true,
      responsiveClass:true,
      responsive:{
        0:{
            items:1,
            nav:false
        },
        600:{
            items:3,
            nav:false
        },
      }
    })
  });
});

$( document ).on('turbolinks:load', function() { 
  //Dropdowns for navbar
  $('body').on('mouseenter mouseleave','.dropdown',function(e){
    var _d=$(e.target).closest('.dropdown');_d.addClass('show');
    setTimeout(function(){
      _d[_d.is(':hover')?'addClass':'removeClass']('show');
    },300);
  });
});

$( document ).on('turbolinks:load', function() { 
  // Scrolling to appropriate area on page
  // Select all links with hashes
  $('a[href*="#"]')
    // Remove links that don't actually link to anything
  .not('[href="#"]')
  .not('[href="#0"]')
  .click(function(event) {
    // On-page links
    if (
      location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
      && 
      location.hostname == this.hostname
    ) {
      // Figure out element to scroll to
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      // Does a scroll target exist?
      if (target.length) {
        // Only prevent default if animation is actually gonna happen
        event.preventDefault();
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 1000, function() {
          // Callback after animation
          // Must change focus!
          var $target = $(target);
          $target.focus();
          if ($target.is(":focus")) { // Checking if the target was focused
            return false;
          } else {
            $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
            $target.focus(); // Set focus again
          };
        });
      }
    }
  });
});


$(document).on('turbolinks:load', function() { 

  /*! Fades in page on load */
  $('body').css('display', 'none');
  $('body').fadeIn(500);

});
