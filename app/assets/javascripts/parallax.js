var reObj;
var xPos;
var coords;

function redraw(obj, shift, y){
    $reObj = obj;
    xPos = -($(window).scrollLeft() * $reObj.data('speed')) - shift;
    coords = xPos + 'px ' + y;
    $reObj.css({ backgroundPosition: coords });
}

$(document).ready(function(){
    $(window).scroll(function() {
        redraw( $('#day_sky'), 0, '50%' );
        redraw( $('#day_forest'), 0, '150px' );
        redraw( $('#day_trees'), 1000, '159px' );
        redraw( $('#day_ducks'), (-1366), '582px' );
        if ($(window).scrollLeft() > 100 && $(window).scrollLeft() < 350) {
            $('#day_info_box').show();
        } else {
            $('#day_info_box').hide();
        };
    });
});
