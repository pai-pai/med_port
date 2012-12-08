var obj;
var xPos;
var coords;
var speed;
var block;
var anchor;

var resizables = new Array ();
resizables[0] = new Array ( "#top_info", "Logo" );
resizables[1] = new Array ( "#clouds", "01_Day_00_Clouds" );
resizables[2] = new Array ( "#swans", "02_Evening_00_Swans" );
resizables[3] = new Array ( "#moon", "03_Night_00_Moon" );
resizables[4] = new Array ( "#ufo", "03_Night_00_UFO" );

function resize(){
    var winHeight = $(window).height();
    if (winHeight < 900) {
        for ( var m=0; m<resizables.length; m++ ) { $(resizables[m][0]).css( "background-image", "url(/assets/" + resizables[m][1] + "_small.png)" ); };
        $("#top_link").css({ "height" : "128px", "width" : "128px" });
        $("#buttons_panel a").css({ "background" : "url(/assets/Button_small.png) 0 -30px no-repeat", "padding" : "8px 0 7px 35px", "line-height" : "30px", "height" : "30px" });
        $("#buttons_panel li").css("margin-bottom", "5px");
        $("#buttons_panel a").hover(function(){ $(this).css("background-position", "0 0") }, function(){ $(this).css("background-position", "0 -30px") });
        $(".mini_block .image").css({ "background-image" : "url(/assets/Badges_small.png)", "height" : "100px", "width" : "100px", "top" : "-50px", "left" : "370px" });
        $("#evening_info .image").css( "background-position", "0 -100px" );
        $("#night_info .image").css( "background-position", "0 -200px" );
        $(".mini_block .stoper").css({ "height" : "50px", "width" : "50px" });
    } else {
        for ( var m=0; m<resizables.length; m++ ) { $(resizables[m][0]).css( "background-image", "url(/assets/" + resizables[m][1] + ".png)" ); };
        $("#top_link").css({ "height" : "192px", "width" : "192px" });
        $("#buttons_panel a").css({ "background" : "url(/assets/Button.png) 0 -45px no-repeat", "padding" : "16px 0 16px 55px", "line-height" : "46px", "height" : "45px" });
        $("#buttons_panel li").css("margin-bottom", "10px");
        $("#buttons_panel a").hover(function(){ $(this).css("background-position", "0 0") }, function(){ $(this).css("background-position", "0 -45px") });
        $(".mini_block .image").css({ "background-image" : "url(/assets/Badges_small_100.png)", "height" : "155px", "width" : "155px", "top" : "-76px", "left" : "344px" });
        $("#evening_info .image").css( "background-position", "0 -155px" );
        $("#night_info .image").css( "background-position", "0 -310px" );
        $(".mini_block .stoper").css({ "height" : "76px", "width" : "76px" });
    };
    $(".mini_block").each( function() {
        if ($(this).is(':hidden')) { 
            $(this).css( "top", "-9000px" ).show();
            $(this).find($(".empty")).css( "height", $(this).find($(".text")).height() - $(this).find($(".stoper")).height() ); 
            $(this).css( "top", "" ).hide();
        } else { 
            $(this).find($(".empty")).css( "height", $(this).find($(".text")).height() - $(this).find($(".stoper")).height() );
        };
    });
    $(".fore").css( "top", (winHeight - $(".fore").height())/2 );
    $(".trees").each(function() { $(this).css({ "top" : ( winHeight/2 + 89 ) - $(this).height(), "background-position" : ($(this).css("background-position").split(" "))[0] + " " + ( ( winHeight/2 + 89 ) - $(this).height() ) + "px" }) });
    $(".forest").each(function() { $(this).css({ "top" : winHeight/2 - 186, "background-position" : ($(this).css("background-position").split(" "))[0] + " " + ( winHeight/2 - 186 ) + "px" }) });
    $("#lilies").css( "top", winHeight/2 + 89 );
    $("#frog").css( "top", winHeight/2 + 89 - $("#frog").height()/2 );
    $("#day_ducks").css({ "top": winHeight - $("#day_ducks").height(), "background-position": ($("#day_ducks").css("background-position").split(" "))[0] + " " + (winHeight - $("#day_ducks").height()) + "px" });
}

function redraw(obj){
    xPos = $(window).scrollLeft() * $(obj[0]).data('speed');
    if (obj[2]=="right") { xPos = - xPos };
    xPos = - xPos + obj[1];
    coords = xPos + "px " + ($(obj[0]).css("background-position").split(" "))[1];
    $(obj[0]).css({ backgroundPosition: coords });
}

function compareScroll(obj){
    if ($(window).scrollLeft() > obj[1] && $(window).scrollLeft() < obj[2]) { $(obj[0]).fadeIn() } else { $(obj[0]).fadeOut() };
}

function goToAnchor(anchor){
    $("body").animate( { scrollLeft: $("a[name='" + anchor + "']").offset().left }, "slow" );
}

var pxObj = new Array ();
pxObj[0]  = new Array ( "#clouds", 1200 );
pxObj[1]  = new Array ( "#swans", 4498 );
pxObj[2]  = new Array ( "#moon", 5132 );
pxObj[3]  = new Array ( "#ufo", 9064 );
pxObj[4]  = new Array ( "#night_sky", 0 );
pxObj[5]  = new Array ( "#day_forest", 0 );
pxObj[6]  = new Array ( "#evening_forest", 0 );
pxObj[7]  = new Array ( "#night_forest", 0 );
pxObj[8]  = new Array ( "#morning_forest", 0 );
pxObj[9]  = new Array ( "#day_trees", 0 );
pxObj[10] = new Array ( "#evening_trees", 2766 );
pxObj[11] = new Array ( "#night_trees", 6079 );
pxObj[12] = new Array ( "#morning_trees", 8992 );
pxObj[13] = new Array ( "#day_ducks", 50, "right");

var cmpObj = new Array ();
cmpObj[0] = new Array ( "#day_info", 75, 375 );
cmpObj[1] = new Array ( "#evening_info", 2591, 3000 );
cmpObj[2] = new Array ( "#night_info", 4827, 5127 );

var time = new Array ( "start", "day", "evening", "night", "morning" );

$(document).ready(function(){
    resize();
    $(window).resize(function() { resize(); });
    $(document).bind("mousewheel", function(event, delta) { $("body").stop().animate( {scrollLeft: $("body").scrollLeft() + (-70 * delta)}, 200 )});
    $(window).scroll(function() {
        for (var j=0; j<pxObj.length; j++) { redraw(pxObj[j]) };
        for (var k=0; k<cmpObj.length; k++) { compareScroll(cmpObj[k]) };
    });
    for (var i=0; i<time.length; i++) {
        $("." + time[i] + "_link").click(function(){ console.log($(this).attr("data-anchor")); goToAnchor( $(this).attr("data-anchor") ) });
    };
});
