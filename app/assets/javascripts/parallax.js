var reObj;
var xPos;
var coords;
var speed;

function redraw(obj, shift, y, moveto){
    xPos = $(window).scrollLeft() * obj.data('speed');
    if (moveto == 'left') { xPos = -(xPos) };
    xPos = xPos - shift;
    coords = xPos + 'px ' + y;
    obj.css({ backgroundPosition: coords });
}

$(document).ready(function(){
    $(window).scroll(function() {
        redraw( $('#day_sky'), 0, '50%', 'right' );
        redraw( $('#night_sky'), 0, '50%', 'left' );
        redraw( $('#evening_forest'), 0, '150px', 'left' );
        redraw( $('#day_forest'), 0, '150px', 'left' );
        redraw( $('#day_trees'), 1000, '159px', 'left' );
        redraw( $('#day_ducks'), 800, '582px', 'right' );
        if ($(window).scrollLeft() > 125 && $(window).scrollLeft() < 675) {
            $('#day_info_box').fadeIn();
        } else {
            $('#day_info_box').fadeOut();
        };
    });
});
