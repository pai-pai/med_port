var obj;
var xPos;
var coords;
var speed;

function resize(){
    if ($("#day_sky").height() < 800) {
        $("#top_info").css( "background-image", "url(/assets/Logo_small.png)" );
    } else {
    };
    $("#fore").css("top", ($(window).height() - $("#fore").height())/2);
    $(".info_box").css({ "height" : $(window).height() - 90, "top" : 20 });
    $("#day_ducks").css({ "top": $(window).height() - $("#day_ducks").height(), "background-position": ($("#day_ducks").css("background-position").split(" "))[0] + " " + ($(window).height() - $("#day_ducks").height()) + "px" });
}

function redraw(obj, shift, moveto){
    xPos = $(window).scrollLeft() * obj.data('speed');
    if (moveto == 'left') { xPos = -(xPos) };
    xPos = xPos - shift;
    coords = xPos + 'px ' + (obj.css("background-position").split(" "))[1];
    obj.css({ backgroundPosition: coords });
}

$(document).ready(function(){
    resize();
    $(document).bind('mousewheel', function(event, delta) {
        $("body").stop().animate( { scrollLeft: $("body").scrollLeft() + (-70 * delta) }, 200 );
    });
    $(window).resize(function(){ 
        resize();
    });
    $(window).scroll(function() {
        redraw( $('#day_sky'), 0, 'left' );
        redraw( $('#night_sky'), 0, 'left' );
        redraw( $('#day_forest'), 0, 'left' );
        redraw( $('#evening_forest'), 0, 'left' );
        redraw( $('#night_forest'), 0, 'left' );
        redraw( $('#morning_forest'), 0, 'left' );
        redraw( $('#day_trees'), 0, 'left' );
        redraw( $('#evening_trees'), -1366, 'left' );
        redraw( $('#night_trees'), -3279, 'left' );
        redraw( $('#morning_trees'), -5192, 'left' );
        redraw( $('#day_ducks'), 800, 'right' );
        /*if ($(window).scrollLeft() > 125 && $(window).scrollLeft() < 675) {
            $('#day_info').fadeIn();
        } else {
            $('#day_info').fadeOut();
        };
        if ($(window).scrollLeft() > 1491 && $(window).scrollLeft() < 2041) {
            $('#evening_info').fadeIn();
        } else {
            $('#evening_info').fadeOut();
        };
        if ($(window).scrollLeft() > 2857 && $(window).scrollLeft() < 3407) {
            $('#night_info').fadeIn();
        } else {
            $('#night_info').fadeOut();
        };
        if ($(window).scrollLeft() > 4098 && $(window).scrollLeft() < 4773) {
            $('#morning_info').fadeIn();
        } else {
            $('#morning_info').fadeOut();
        };*/
    });
});
