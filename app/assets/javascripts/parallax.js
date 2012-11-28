var obj;
var xPos;
var coords;
var speed;

function redraw(obj, shift, moveto){
    xPos = $(window).scrollLeft() * obj.data('speed');
    if (moveto == 'left') { xPos = -(xPos) };
    xPos = xPos - shift;
    console.log(parseFloat((obj.css("background-position").split(" "))[0]));
    coords = xPos + 'px ' + (obj.css("background-position").split(" "))[1];
    obj.css({ backgroundPosition: coords });
}

$(document).ready(function(){
    $(document).bind('mousewheel', function(event, delta) {
        $("body").stop().animate( { scrollLeft: $("body").scrollLeft() + (-70 * delta) }, 200 );
    });
    $(window).scroll(function() {
        redraw( $('#day_sky'), 0, 'left' );
        redraw( $('#night_sky'), 0, 'left' );
        redraw( $('#evening_forest'), 0, 'left' );
        redraw( $('#day_forest'), 0, 'left' );
        redraw( $('#day_trees'), 0, 'left' );
        redraw( $('#evening_trees'), -1366, 'left' );
        redraw( $('#night_trees'), -3279, 'left' );
        redraw( $('#morning_trees'), -5192, 'left' );
        redraw( $('#day_ducks'), 800, 'right' );
        if ($(window).scrollLeft() > 125 && $(window).scrollLeft() < 675) {
            $('#day_info_box').fadeIn();
        } else {
            $('#day_info_box').fadeOut();
        };
    });
});
