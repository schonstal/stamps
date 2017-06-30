package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class MenuState extends FlxState {
  var bankbar:FlxSprite;

  override public function create():Void {
    super.create();
    Reg.background = new FlxSprite();
    Reg.background.loadGraphic("assets/images/backgrounds/notebook.png");
    add(Reg.background);

    bankbar = new FlxSprite();
    bankbar.y = FlxG.height - 74;
    bankbar.loadGraphic("assets/images/ui/toolbars.png", true, 640, 74);
    bankbar.animation.add("wiggle", [0, 1, 2], 8, true);
    bankbar.animation.play("wiggle");
    add(bankbar);

    FlxG.mouse.load("assets/images/ui/pointer.png");

    FlxG.sound.playMusic("assets/music/intro.ogg", 0.8);
  }

  override public function update(elapsed:Float):Void {
    if (FlxG.mouse.justPressed) {
      FlxG.switchState(new PlayState());
    }

    super.update(elapsed);
  }
}
