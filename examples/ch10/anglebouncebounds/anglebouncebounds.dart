#import('dart:html');
#import('../../include/utilslib.dart', prefix:'utilslib');
#source('../classes/ball.dart');
#source('../classes/bound.dart');
#source('../classes/line.dart');

class anglebouncebounds {

  anglebouncebounds() {
  }

  void run() {
    CanvasElement canvas = document.query('#canvas');
    var context = canvas.getContext('2d');
    var mouse = utilslib.Utils.captureMouse(canvas);
    var ball = new Ball();
    var line = new Line.withParameters(0, 0, 300, 0);
    var gravity = 0.2,
        bounce = -0.6;
    
    ball.x = 100;
    ball.y = 100;

    line.x = 50;
    line.y = 200;
    
    drawFrame(int t) {
      document.window.webkitRequestAnimationFrame(drawFrame, canvas);
      context.clearRect(0, 0, canvas.width, canvas.height);
      
      var bounds = line.getBounds();
      //move line with mouse
      line.rotation = ((canvas.width / 2 - mouse.x) * 0.1) * Math.PI / 180;
      //normal motion code
      ball.vy += gravity;
      ball.x += ball.vx;
      ball.y += ball.vy;
      
      if (ball.x + ball.radius > bounds.x && ball.x - ball.radius < bounds.x + bounds.width) {
        //get angle, sine, and cosine
        var cos = Math.cos(line.rotation),
            sin = Math.sin(line.rotation),
            //get position of ball, relative to line
            x1 = ball.x - line.x,
            y1 = ball.y - line.y,
            //rotate coordinates
            y2 = cos * y1 - sin * x1;
        //perform bounce with rotated values
        if (y2 > -ball.radius) {
          //rotate coordinates
          var x2 = cos * x1 + sin * y1,
              //rotate velocity
              vx1 = cos * ball.vx + sin * ball.vy,
              vy1 = cos * ball.vy - sin * ball.vx;
          y2 = -ball.radius;
          vy1 *= bounce;
          //rotate everything back
          x1 = cos * x2 - sin * y2;
          y1 = cos * y2 + sin * x2;
          ball.vx = cos * vx1 - sin * vy1;
          ball.vy = cos * vy1 + sin * vx1;
          ball.x = line.x + x1;
          ball.y = line.y + y1;
        }
      }
      ball.draw(context);
      line.draw(context);
    };
    
    drawFrame(0);
  }
}

void main() {
  new anglebouncebounds().run();
}
