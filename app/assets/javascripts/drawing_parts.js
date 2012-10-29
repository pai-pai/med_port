var canvas;
var context;
var canvasWidth = 400;
var canvasHeight = 355;
var paint = false;
var clickX = new Array();
var clickY = new Array();
var clickDrag = new Array();
var backImage = new Image();

function prepareCanvas(){
    var canvasDiv = document.getElementById('canvasDiv');
    canvas = document.createElement('canvas');
    canvas.setAttribute('width', canvasWidth);
    canvas.setAttribute('height', canvasHeight);
    canvas.setAttribute('id', 'canvas');
    canvasDiv.appendChild(canvas);
    if(typeof G_vmlCanvasManager != 'undefined') {
        canvas = G_vmlCanvasManager.initElement(canvas);
    }
    context = canvas.getContext("2d");
    //drawBackground();

    $('#canvas').mousedown(function(e){
        var mouseX = e.pageX - this.offsetLeft;
        var mouseY = e.pageY - this.offsetTop;
        if (clickX.length == 0) {
            context.beginPath();
            context.moveTo(mouseX, mouseY);
            paint = true;
        } else {
            context.lineTo(mouseX, mouseY);
            context.clearRect(0, 0, canvasWidth, canvasHeight);
            context.stroke();
        };
        addPoint(mouseX, mouseY);
    });
}

function drawBackground(){
    backImage.onload = function() {
        context.drawImage(backImage, 0, 0, canvasWidth, canvasHeight);
    };
    backImage.src = "http://0.0.0.0:3000/assets/Nyan_Cat.jpg";
}

function addPoint(x, y){
    clickX.push(x);
    clickY.push(y); 
}

function clearCanvas(){
    clickX = new Array();
    clickY = new Array();
    paint = false;
    context.clearRect(0, 0, canvasWidth, canvasHeight);
   // drawBackground();
}

function closing(){
    if (clickX.length > 2) { 
        context.closePath();
        context.clearRect(0, 0, canvasWidth, canvasHeight);
        context.stroke();
        paint = false;
        str = clickX.join(", ") + ": " + clickY.join(", ");
        console.log(str);
    };
}

window.onload = function() {
    prepareCanvas();
}

$(document).ready(function(){
    $('#clear').click(function(){ clearCanvas(); });
    $('#close_path').click(function(){ closing(); });
})
