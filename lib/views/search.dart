import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperpileapp/data/data.dart';
import 'package:wallpaperpileapp/model/wallpaper_model.dart';
import 'package:wallpaperpileapp/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

class Search extends StatefulWidget {

  final String givenSearch;

  Search({@required this.givenSearch});


  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController secondSearchController = TextEditingController();

  List<WallpaperModel> wallpapers = [];

  getParticularWallpaper(String query) async {

    String url = "https://api.pexels.com/v1/search?query=$query&per_page=80";
    logger.i(url);

    await http.get(
        Uri.parse(url),
        headers: {"Authorization": apiKey}).then((value) {

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        WallpaperModel wallpaperModel = WallpaperModel(photographer: "", photographer_id: 0, photographer_url: "", src: SourceModel(original: "", small: "", portrait: ""));
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    logger.i(widget.givenSearch.length);
    getParticularWallpaper(widget.givenSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30)
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(children: <Widget>[
                 Expanded(
                  child: TextField(
                    controller: secondSearchController,
                    decoration: InputDecoration(
                        hintText: "search wallpaper",
                        border: InputBorder.none
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    wallpapers = [];
                    getParticularWallpaper(secondSearchController.text);
                  },
                  child: Container(
                      child: Icon(Icons.search)),
                )
              ],
              ),
            ),
            const SizedBox(height: 16,),
            wallpaperList(wallpapers, context)
          ],
        ),
      ),
    );

  }
}
