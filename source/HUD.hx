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

  var toolbarTweenIn:FlxTween;
  var toolbarTweenOut:FlxTween;

  var mode:String = "background";
  var index:Int = 0;

  var stampBank:OptionBank;
  var brushBank:OptionBank;
  var backgroundBank:OptionBank;

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
    createBanks();
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
  }

  private function createBanks():Void {
    backgroundBank = new OptionBank();
    stampBank = new OptionBank();
    brushBank = new OptionBank();

    var thumbnailPaths:Array<String> = PathHelper.imagesForPath(~/images\/backgrounds\/thumbs/);
    thumbnailGroup = new OptionGroup(
      thumbnailPaths.slice(0, 6),
      "background",
      FlxG.height - 68
    );
    backgroundBank.add(thumbnailGroup);

    thumbnailPaths = PathHelper.imagesForPath(~/images\/stamps\/thumbs/);
    thumbnailGroup = new OptionGroup(
      thumbnailPaths,
      "stamp",
      FlxG.height - 68
    );
    stampBank.add(thumbnailGroup);

    thumbnailPaths = PathHelper.imagesForPath(~/images\/palette\/thumbs/);
    thumbnailGroup = new OptionGroup(
      thumbnailPaths,
      "stamp",
      FlxG.height - 68
    );
    brushBank.add(thumbnailGroup);

    add(backgroundBank);
    add(brushBank);
    add(stampBank);
  }

  private function createIcons():Void {
    icons = new FlxSpriteGroup();

    var thumbnail:ThumbnailFrame = new ThumbnailFrame("assets/images/ui/icons/bg.png");
    thumbnail.x = 68;
    thumbnail.clickCallback = function():Void {
      stampBank.hide();
      brushBank.hide();
      backgroundBank.show();
    }
    thumbnail.appear();
    icons.add(thumbnail);

    thumbnail = new ThumbnailFrame("assets/images/ui/icons/pencil.png");
    thumbnail.x = 157;
    thumbnail.clickCallback = function():Void {
      stampBank.hide();
      brushBank.show();
      backgroundBank.hide();
      Reg.continuous = true;
    }
    thumbnail.appear();
    icons.add(thumbnail);

    thumbnail = new ThumbnailFrame("assets/images/ui/icons/stamp.png");
    thumbnail.x = 246;
    thumbnail.clickCallback = function():Void {
      stampBank.show();
      brushBank.hide();
      backgroundBank.hide();
      Reg.continuous = false;
    }
    thumbnail.appear();
    icons.add(thumbnail);

    add(icons);
  }
}
