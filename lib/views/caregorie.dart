import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperpileapp/data/data.dart';
import 'package:wallpaperpileapp/model/wallpaper_model.dart';
import 'package:wallpaperpileapp/widgets/widget.dart';


class CategorieScreen extends StatefulWidget {
  final String categorieName;

  CategorieScreen({@required this.categorieName});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<WallpaperModel> wallpapers = [];

  getCategorieWallpaper() async {

    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=${widget.categorieName}&per_page=30&page=1"),
        headers: {"Authorization": apiKey}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        WallpaperModel wallpaperModel = WallpaperModel(photographer: "", photographer_id: 0, photographer_url: "", src: SourceModel(original: "", small: "", portrait: ""));
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: wallpaperList(wallpapers, context)
        ,
      ),
    );
  }
}