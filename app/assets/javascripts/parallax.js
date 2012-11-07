$(document).ready(function(){
    $('*[data-type="background"]').each(function(){
        var $bgobj = $(this); // assigning the object
        $(window).scroll(function() {
            var xPos = -($(window).scrollLeft() * $bgobj.data('speed'));
            // Put together our final background position
            var coords = xPos + 'px 50%';
            // Move the background
            $bgobj.css({ backgroundPosition: coords });
        });
    });
});
