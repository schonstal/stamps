package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class HUD extends FlxGroup {
  var scoreText:FlxBitmapText;
  var toolbar:FlxSprite;
  var bankbar:FlxSprite;
  var thumbnailGroup:OptionGroup;
  var muteIndicator:FlxSprite;

  var toolbarTweenIn:FlxTween;
  var toolbarTweenOut:FlxTween;

  var mode:String = "background";
  var index:Int = 0;

  var stampGroup:OptionGroup;
  var brushGroup:OptionGroup;
  var backgroundGroup:OptionGroup;

  var icons:FlxSpriteGroup;

  public function new():Void {
    super();
    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    bankbar = new FlxSprite();
    bankbar.y = FlxG.height - 74;
    bankbar.loadGraphic("assets/images/ui/toolbars.png", true, 640, 74);
    bankbar.animation.add("wiggle", [0, 1, 2], 8, true);
    bankbar.animation.play("wiggle");
    add(bankbar);

    toolbar = new FlxSprite();
    toolbar.angle = 180;
    toolbar.y = -40;
    toolbar.loadGraphic("assets/images/ui/toolbars.png", true, 640, 74);
    toolbar.animation.add("wiggle", [2, 1, 0], 8, true);
    toolbar.animation.play("wiggle");
    add(toolbar);

    scoreText = new FlxBitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "0";
    scoreText.x = 4;
    scoreText.y = 4;
    // add(scoreText);

    createIcons();
    createGroups();
  }

  public override function update(elapsed:Float):Void {
    scoreText.text = "" + Reg.score;

    if (FlxG.mouse.y < toolbar.y + toolbar.height) {
      if (toolbarTweenIn == null || !toolbarTweenIn.active) {
        toolbarTweenIn = FlxTween.tween(toolbar, { y: 0 }, 0.25, { ease: FlxEase.quadOut });
        if (toolbarTweenOut != null && toolbarTweenOut.active) {
          toolbarTweenOut.cancel();
        }
      }
    } else {
      if (toolbarTweenOut == null || !toolbarTweenOut.active) {
        toolbarTweenOut = FlxTween.tween(toolbar, { y: -40 }, 0.25, { ease: FlxEase.quadOut });
        if (toolbarTweenIn != null && toolbarTweenIn.active) {
          toolbarTweenIn.cancel();
        }
      }
    }

    super.update(elapsed);

    icons.y = toolbar.y;

    if (FlxG.mouse.y > bankbar.y || FlxG.mouse.y < toolbar.y + toolbar.height) {
      Reg.stamp.visible = false;
    } else {
      Reg.stamp.visible = true;
    }

    muteIndicator.visible = !FlxG.sound.muted;
  }

  private function createGroups():Void {
    backgroundGroup = new BackgroundGroup();
    stampGroup = new StampsGroup();
    brushGroup = new BrushGroup();

    add(backgroundGroup);
    add(brushGroup);
    add(stampGroup);
  }

  private function createIcons():Void {
    icons = new FlxSpriteGroup();

    var thumbnail:ThumbnailFrame = new ThumbnailFrame("assets/images/ui/icons/bg.png");
    thumbnail.x = 68;
    thumbnail.clickCallback = function():Void {
      stampGroup.hide();
      brushGroup.hide();
      backgroundGroup.show();
    }
    thumbnail.appear();
    icons.add(thumbnail);

    thumbnail = new ThumbnailFrame("assets/images/ui/icons/pencil.png");
    thumbnail.x = 157;
    thumbnail.clickCallback = function():Void {
      stampGroup.hide();
      brushGroup.show();
      backgroundGroup.hide();
    }
    thumbnail.appear();
    icons.add(thumbnail);

    thumbnail = new ThumbnailFrame("assets/images/ui/icons/stamp.png");
    thumbnail.x = 246;
    thumbnail.clickCallback = function():Void {
      stampGroup.show();
      brushGroup.hide();
      backgroundGroup.hide();
    }
    thumbnail.appear();
    icons.add(thumbnail);

    thumbnail = new ThumbnailFrame("assets/images/ui/icons/clear.png");
    thumbnail.x = 335;
    thumbnail.clickCallback = function():Void {
      Reg.canvas.clear();
      FlxG.sound.play("assets/sounds/rejected.ogg");
    }
    thumbnail.appear();
    icons.add(thumbnail);

    thumbnail = new ThumbnailFrame("assets/images/ui/icons/audiobase.png");
    thumbnail.x = 424;
    thumbnail.clickCallback = function():Void {
      FlxG.sound.muted = !FlxG.sound.muted;
    }
    thumbnail.appear();
    icons.add(thumbnail);

    muteIndicator = new FlxSprite();
    muteIndicator.loadGraphic("assets/images/ui/icons/audioOn.png");
    muteIndicator.x = thumbnail.x;
    icons.add(muteIndicator);

    add(icons);
  }
}
