#import('dart:html');
#import('../../include/utilslib.dart', prefix:'utilslib');
#source('../classes/segment.dart');
#source('../classes/point.dart');
#source('../classes/bound.dart');

class walking2 {

  walking2() {
  }

  void run() {
    CanvasElement canvas = document.query('#canvas');
    var context = canvas.getContext('2d');
    var segment0 = new Segment(100, 20),
        segment1 = new Segment(100, 20),
        cycle = 0;
    
    segment0.x = 200;
    segment0.y = 200;
    
    segment1.x = segment0.getPin().x;
    segment1.y = segment0.getPin().y;   
    drawFrame(int t) {
      document.window.webkitRequestAnimationFrame(drawFrame, canvas);
      context.clearRect(0, 0, canvas.width, canvas.height);
      
      cycle += 0.02;
      var angle0 = (Math.sin(cycle) * 45 + 90) * Math.PI / 180,
          angle1 = (Math.sin(cycle) * 45 + 45) * Math.PI / 180;
      
      segment0.rotation = angle0;
      segment1.rotation = segment0.rotation + angle1;
      segment1.x = segment0.getPin().x;
      segment1.y = segment0.getPin().y;
      segment0.draw(context);
      segment1.draw(context);
    };
    
    drawFrame(0);
  }
}

void main() {
  new walking2().run();
}
