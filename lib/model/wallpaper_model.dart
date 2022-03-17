import 'package:flutter/cupertino.dart';

class WallpaperModel{

   String photographer;
   int photographer_id;
   String photographer_url;
   SourceModel src;

  WallpaperModel({ @required this.photographer,@required this.photographer_id,@required this.photographer_url,@required this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData){
    return WallpaperModel(
      src: SourceModel.fromMap(jsonData["src"]),
      photographer: jsonData["photographer"],
      photographer_id: jsonData["photographer_id"],
      photographer_url: jsonData["photographer_url"]
    );
  }

}

class SourceModel{

   String original;
   String small;
   String portrait;

  SourceModel({@required this.original,@required this.small,@required this.portrait});

  factory SourceModel.fromMap(Map<String, dynamic> srcJson) {
    return SourceModel(
        portrait: srcJson["portrait"],
        original: srcJson["original"],
        small: srcJson["small"]);
  }

}