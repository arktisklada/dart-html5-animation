class Utils {
  static parseColor(var color, var toNumber) {
    if (toNumber === true) {
      if (color is num) {
        return (color | 0); // chop off decimal
      }
      
     
      if (color is String && color.startsWith('#')) {
        String s = color;
        s = s.substring(1);
        int i = Math.parseInt(s);
        return i;
      }
      
  
    } else {
      if (color is num) {
        
        int r;
        int g;
        int b;
        r = (color&0xff0000)>>16;
        g = (color&0x00ff00)>>8;
        b = color&0x0000ff;
        
        /*
        int i = 0x112233;
        print(i.toRadixString(16));
        print(((i&0xff0000)>>16).toRadixString(16));
        print(((i&0x00ff00)>>8).toRadixString(16));
        print((i&0x0000ff).toRadixString(16));
        */
        return '#' + r.toRadixString(16) + g.toRadixString(16) + b.toRadixString(16);
      }
    }
  }
  
  static Mouse captureMouse(var element) {
    Mouse mouse = new Mouse();
    // non of the Element.scroll* is available in htmllib for whatever reason. 
    // we are better off with offsetX/offsetY
    //var body_scrollLeft = 0; // document.body.scrollLeft;
    //var element_scrollLeft = 0; // document.document.scrollLeft;
    //var body_scrollTop = 0; // document.body.scrollTop;
    //var element_scrollTop = 0; // document.document.scrollTop;
    //var offsetLeft = 0; // element.scrollLeft; //element.offsetLeft;
    //var offsetTop = 0; //element.scrollTop; //element.offsetTop;
    
    element.on.mouseMove.add((MouseEvent e) {
      /*
      int x;
      int y;
      
      if (e.pageX  > 0 || e.pageY > 0) {
        x = e.pageX;
        y = e.pageY;
      } else {
        x = e.clientX + body_scrollLeft + element_scrollLeft;
        y = e.clientY + body_scrollTop + element_scrollTop;
      }
      
      x -= offsetLeft;
      y -= offsetTop;
      */
      //print('e.offsetX = ' + e.offsetX);
      //print('e.offsetY = ' + e.offsetY);
      
      mouse.x = e.offsetX;
      mouse.y = e.offsetY;
      mouse.event = e;
    });
    
    return mouse;
  }
}
