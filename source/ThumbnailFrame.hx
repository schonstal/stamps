package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.util.FlxSpriteUtil;

class ThumbnailFrame extends FlxSpriteGroup {
  public var clickCallback:Void->Void;

  var frameSprite:FlxSprite;
  var thumbSprite:FlxSprite;
  var thumbSpriteMask:FlxSprite;
  var thumbOutput:FlxSprite;

  var sinAmt:Float;

  var frameScaleTween:FlxTween;
  var frameAngleTween:FlxTween;
  var thumbScaleTween:FlxTween;
  var thumbAngleTween:FlxTween;

  public function new(thumbnailPath:String):Void {
    super(0, 0);

    var frames = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    Reg.random.shuffle(frames);
    var frames = frames.slice(0, 3);

    thumbOutput = new FlxSprite();
    thumbOutput.makeGraphic(640, 64, 0xffffffff, true);

    thumbSprite = new FlxSprite();
    thumbSprite.loadGraphic(thumbnailPath);

    thumbSpriteMask = new FlxSprite();
    thumbSpriteMask.loadGraphic("assets/images/ui/toolBordersMask.png");

    for (i in 0...10) {
      thumbOutput.stamp(thumbSprite, i * 64, 0);
    }

    FlxSpriteUtil.alphaMaskFlxSprite(thumbOutput, thumbSpriteMask, thumbSprite);
    thumbSprite.frames = FlxTileFrames.fromGraphic(thumbSprite.graphic, FlxPoint.get(64, 64));
    thumbSprite.animation.add("wiggle", frames, 8, true);
    thumbSprite.animation.play("wiggle");
    add(thumbSprite);

    frameSprite = new FlxSprite();
    frameSprite.loadGraphic("assets/images/ui/toolBorders.png", true, 64, 64);
    frameSprite.animation.add("wiggle", frames, 8, true);
    frameSprite.animation.play("wiggle");
    add(frameSprite);

    thumbSprite.scale.x = 0;
    thumbSprite.scale.y = 0;
    thumbSprite.angle = 45;

    frameSprite.scale.x = 0;
    frameSprite.scale.y = 0;
    frameSprite.angle = 45;
  }

  public function appear():Void {
    frameSprite.scale.x = 0;
    frameSprite.scale.y = 0;
    frameSprite.angle = 45;

    thumbSprite.scale.x = 0;
    thumbSprite.scale.y = 0;
    thumbSprite.angle = 45;

    new FlxTimer().start(Reg.random.float(0, 0.25), function(t):Void {
      frameScaleTween = FlxTween.tween(frameSprite.scale, { x: 1, y: 1 }, 0.5, { ease: FlxEase.elasticOut });
      frameAngleTween = FlxTween.tween(frameSprite, { angle: 0 }, 0.5, { ease: FlxEase.elasticOut });

      thumbScaleTween = FlxTween.tween(thumbSprite.scale, { x: 1, y: 1 }, 0.5, { ease: FlxEase.elasticOut });
      thumbAngleTween = FlxTween.tween(thumbSprite, { angle: 0 }, 0.5, { ease: FlxEase.elasticOut });
    });
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if (frameScaleTween == null || !frameScaleTween.finished) { return; }

    sinAmt += 7 * elapsed;

    if (FlxG.mouse.x > x && FlxG.mouse.x < x + width &&
        FlxG.mouse.y > y && FlxG.mouse.y < y + height) {
      angle = 20 * Math.sin(sinAmt);
      scale.y = scale.x = 1 + (Math.cos(sinAmt) * 0.3);
      if (FlxG.mouse.justPressed && clickCallback != null) {
        clickCallback();
      }
    } else {
      angle = 0;
      scale.x = scale.y = 1;
    }
  }
}
