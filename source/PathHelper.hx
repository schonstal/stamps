import openfl.Assets;

class PathHelper {
  public static function imagesForPath(pathRegex:EReg):Array<String> {
    var imagePaths:Array<String> = Assets.list(AssetType.IMAGE);

    return imagePaths.filter(function(path:String):Bool {
      return pathRegex.match(path);
    });
  }
}
