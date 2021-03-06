$(function(){
  $('.search-toggle').click(function() {
    $('.search-show-hide').toggle();
    $('.search-box').focus();
    $('.fa-search').toggleClass('fa-times');
  });
});

$(function(){
  //Dropdowns for navbar
  $('body').on('mouseenter mouseleave','.dropdown',function(e){
    var _d=$(e.target).closest('.dropdown');_d.addClass('show');
    setTimeout(function(){
      _d[_d.is(':hover')?'addClass':'removeClass']('show');
    },300);
  });
});

$(function(){
  //Atb on product lister items
  $(".lister-product-container").hover(
    function() {
      $(".lister-product-image-overlay", this).first().fadeIn(200);        
    }, function() {
      $(".lister-product-image-overlay", this).first().fadeOut(200); 
    }
  );
});



$(function(){ 
  $("img").lazyload({
    threshold : 500,
    effect : "fadeIn"
   });
});

// $(function(){
//   // Scrolling to appropriate area on page
//   // Select all links with hashes
//   $('a[href*="#"]')
//     // Remove links that don't actually link to anything
//   .not('[href="#"]')
//   .not('[href="#0"]')
//   .click(function(event) {
//     // On-page links
//     if (
//       location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
//       && 
//       location.hostname == this.hostname
//     ) {
//       // Figure out element to scroll to
//       var target = $(this.hash);
//       target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
//       // Does a scroll target exist?
//       if (target.length) {
//         // Only prevent default if animation is actually gonna happen
//         event.preventDefault();
//         $('html, body').animate({
//           scrollTop: target.offset().top
//         }, 1000, function() {
//           // Callback after animation
//           // Must change focus!
//           var $target = $(target);
//           $target.focus();
//           if ($target.is(":focus")) { // Checking if the target was focused
//             return false;
//           } else {
//             $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
//             $target.focus(); // Set focus again
//           };
//         });
//       }
//     }
//   });
// });


// Get rid of flash on load - doesn't need it now we don't have turbolinks
// $(function(){ 

//   /*! Fades in page on load */
//   $('body').css('display', 'none');
//   $('body').fadeIn(500);

// });

// $(function(){ 
//   var stickyNavTop = $('.secondary-nav').offset().top;
    
//   // our function that decides weather the navigation bar should have "fixed" css position or not.
//   var stickyNav = function(){
//     var scrollTop = $(window).scrollTop(); // our current vertical position from the top
         
//     // if we've scrolled more than the navigation, change its position to fixed to stick to top,
//     // otherwise change it back to relative
//     if (scrollTop > stickyNavTop) { 
//         $('.secondary-nav').addClass('sticky');
//     } else {
//         $('.secondary-nav').removeClass('sticky'); 
//     }
//   };

//   stickyNav();
//   // and run it again every time you scroll
//   $(window).scroll(function() {
//     stickyNav();
//   });
// });

