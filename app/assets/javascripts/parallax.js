var obj;
var xPos;
var coords;
var speed;
var anchor;
var time;

time = [ "day", "evening", "night", "morning" ];

function resize(){
    if ($(window).height() < 900) {
        $("#top_info").css( "background-image", "url(/assets/Logo_small.png)" );
        $("#clouds").css( "background-image", "url(/assets/01_Day_00_Clouds_small.png)" );
        $("#swans").css("background-image", "url(/assets/02_Evening_00_Swans_small.png)");
        $("#moon").css("background-image", "url(/assets/03_Night_00_Moon_small.png)");
        $("#ufo").css("background-image", "url(/assets/03_Night_00_UFO_small.png)");
        $("#buttons_panel a").css({ "background" : "url(/assets/Button_small.png) 0 -30px no-repeat", "padding" : "8px 0 8px 35px", "line-height" : "30px", "height" : "30px" });
        $("#buttons_panel li").css("margin-bottom", "5px");
        $("#buttons_panel a").hover(function(){ $(this).css("background-position", "0 0") }, function(){ $(this).css("background-position", "0 -30px") });
    } else {
        $("#top_info").css( "background-image", "url(/assets/Logo.png)" );
        $("#clouds").css( "background-image", "url(/assets/01_Day_00_Clouds.png)" );
        $("#swans").css("background-image", "url(/assets/02_Evening_00_Swans.png)");
        $("#moon").css("background-image", "url(/assets/03_Night_00_Moon.png)");
        $("#ufo").css("background-image", "url(/assets/03_Night_00_UFO.png)");
        $("#buttons_panel a").css({ "background" : "url(/assets/Button.png) 0 -45px no-repeat", "padding" : "16px 0 16px 55px", "line-height" : "46px", "height" : "45px" });
        $("#buttons_panel li").css("margin-bottom", "10px");
    };
    $(".fore").css( "top", ($(window).height() - $(".fore").height())/2 );
    $(".trees").each(function() { $(this).css({ "top" : ( ($(window).height())/2 + 89 ) - $(this).height(), "background-position" : ($(this).css("background-position").split(" "))[0] + " " + ( ( ($(window).height())/2 + 89 ) - $(this).height() ) + "px" }) });
    $(".forest").each(function() { $(this).css({ "top" : ($(window).height())/2 - 186, "background-position" : ($(this).css("background-position").split(" "))[0] + " " + ( ($(window).height())/2 - 186 ) + "px" }) });
    $("#lilies").css( "top", ($(window).height())/2 + 89 );
    $("#frog").css( "top", ($(window).height())/2 + 89 - $("#frog").height()/2 );
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

function goToAnchor(anchor){
    $("body").animate( { scrollLeft: $("a[name='" + anchor + "']").offset().left }, "slow" );
}

$(document).ready(function(){
    resize();
    $(document).bind('mousewheel', function(event, delta) {
        $("body").stop().animate( { scrollLeft: $("body").scrollLeft() + (-70 * delta) }, 200 );
    });
    $(window).resize(function(){ resize(); });
    $(window).scroll(function() {
        redraw( $('#clouds'), -1200, 'left' );
        redraw( $('#swans'), -5998, 'left' );
        redraw( $('#moon'), -5132, 'left' );
        redraw( $('#ufo'), -10664, 'left' );
        redraw( $('#night_sky'), 0, 'left' );
        redraw( $('#day_forest'), 0, 'left' );
        redraw( $('#evening_forest'), 0, 'left' );
        redraw( $('#night_forest'), 0, 'left' );
        redraw( $('#morning_forest'), 0, 'left' );
        redraw( $('#day_trees'), 0, 'left' );
        redraw( $('#evening_trees'), -2766, 'left' );
        redraw( $('#night_trees'), -6079, 'left' );
        redraw( $('#morning_trees'), -8992, 'left' );
        redraw( $('#day_ducks'), 800, 'right' );
        /*if ($(window).scrollLeft() > 125 && $(window).scrollLeft() < 675) {
            $('#day_info').fadeIn();
        } else {
            $('#day_info').fadeOut();
        };*/
    });
    for (var i=0; i<time.length; i++) {
        $("#" + time[i] + "_link").click(function(){ console.log($(this).attr("data-anchor")); goToAnchor( $(this).attr("data-anchor") ) });
    };
});
