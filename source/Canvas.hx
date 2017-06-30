package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

class Canvas extends FlxSprite {
  var wasPainting:Bool = false;
  var lastPosition:FlxPoint = new FlxPoint(0, 0);
  var drawingSound:FlxSound;

  public function new():Void {
    super();
    clear();
    drawingSound = FlxG.sound.load("assets/sounds/drawing.ogg", 1, true);
  }

  public function clear():Void {
    makeGraphic(640, 480, 0, true);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if (FlxG.mouse.pressed && Reg.stamp != null && Reg.continuous && Reg.stamp.visible) {
      stamp(Reg.stamp, Std.int(Reg.stamp.x), Std.int(Reg.stamp.y));
      drawingSound.play();

      if(wasPainting == true) {
        var dx:Float = lastPosition.x - Reg.stamp.x;
        var dy:Float = lastPosition.y - Reg.stamp.y;

        var a:Float = Math.atan2(-dy, -dx);
        var xIncrement:Float = Math.cos(a);
        var yIncrement:Float = Math.sin(a);
        var d:Float = Math.sqrt(dx*dx+dy*dy);

        for(i in (0...Std.int(d))) {
          stamp(Reg.stamp,
                Std.int(lastPosition.x + (xIncrement * i)),
                Std.int(lastPosition.y + (yIncrement * i)));
        }
      }

      wasPainting = true;
    } else {
      drawingSound.stop();
      wasPainting = false;
    }

    if (FlxG.mouse.justPressed && Reg.stamp != null && !Reg.continuous && Reg.stamp.visible) {
      if (Reg.stampSound != null) {
        Reg.stampSound.play(true);
      }
      stamp(Reg.stamp, Std.int(Reg.stamp.x), Std.int(Reg.stamp.y));
    }

    lastPosition.x = Reg.stamp.x;
    lastPosition.y = Reg.stamp.y;
  }
}
