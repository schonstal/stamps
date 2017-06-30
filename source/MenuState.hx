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
  var chuck:FlxSprite;
  var text:FlxSprite;
  var clickText:FlxSprite;

  override public function create():Void {
    super.create();
    Reg.background = new FlxSprite();
    Reg.background.loadGraphic("assets/images/backgrounds/notebook.png");
    add(Reg.background);

    chuck = new FlxSprite();
    chuck.loadGraphic("assets/images/splash/justChuck.png");
    chuck.y = 480;
    add(chuck);

    text = new FlxSprite();
    text.loadGraphic("assets/images/splash/textSpriteSheet.png", true, 640, 138);
    text.animation.add("wiggle", [0, 1, 2], 8, true);
    text.animation.play("wiggle");
    text.y = 30;
    text.visible = false;
    add(text);

    bankbar = new FlxSprite();
    bankbar.y = FlxG.height - 74;
    bankbar.loadGraphic("assets/images/ui/toolbars.png", true, 640, 74);
    bankbar.animation.add("wiggle", [0, 1, 2], 8, true);
    bankbar.animation.play("wiggle");
    add(bankbar);

    clickText = new FlxSprite();
    clickText.loadGraphic("assets/images/splash/clickStartSpriteSheet.png", true, 640, 34);
    clickText.animation.add("wiggle", [0, 1, 2], 8, true);
    clickText.animation.play("wiggle");
    clickText.visible = false;
    clickText.y = FlxG.height - 50;
    add(clickText);

    FlxG.mouse.load("assets/images/ui/pointer.png");

    FlxTween.tween(chuck, { y: 0 }, 1, {
      ease: FlxEase.quadOut,
      onComplete: function(t):Void {
        FlxG.sound.play("assets/sounds/cheer.ogg");
        text.visible = true;
        clickText.visible = true;
        FlxG.sound.playMusic("assets/music/intro.ogg", 0.8);
      }
    });
  }

  override public function update(elapsed:Float):Void {
    if (FlxG.mouse.justPressed && clickText.visible) {
      FlxG.switchState(new PlayState());
    }

    super.update(elapsed);
  }
}
