import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperpileapp/data/data.dart';
import 'package:wallpaperpileapp/model/categorie_model.dart';
import 'package:wallpaperpileapp/model/wallpaper_model.dart';
import 'package:wallpaperpileapp/views/caregorie.dart';
import 'package:wallpaperpileapp/views/search.dart';
import 'package:wallpaperpileapp/widgets/widget.dart';
import 'package:http/http.dart' as http;



class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void> requestStoragePermission() async {

    final serviceStatus = await Permission.storage.isGranted ;

    bool isStorageOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  List<CategorieModel> categories =  List.empty();

  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = TextEditingController();

  getDefaultWallpapers() async{

    var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          "Authorization" : apiKey
    });

     Map<String,dynamic> jsonData = jsonDecode(response.body);
     jsonData["photos"].forEach((element){
       // print(element);
       WallpaperModel wallpaperModel = WallpaperModel(photographer: "", photographer_id: 0, photographer_url: "", src: SourceModel(original: "", small: "", portrait: ""));
       wallpaperModel = WallpaperModel.fromMap(element);
       wallpapers.add(wallpaperModel);
     });
    setState(() {});
   }


  @override
  void initState() {
    requestStoragePermission();
    getDefaultWallpapers();
    categories = getCategories();
    super.initState();
  }

  // @override
  // void dispose() {
  //   searchController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Container(child: Column(
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
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "search wallpaper",
                            border: InputBorder.none
                      ),
                    ),
                  ),
                InkWell(
                  onTap: (){
                  if (searchController.text != "") {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            Search(
                              givenSearch: searchController.text,
                            )));
                    }
                  },
                  child: Container(
                     child: Icon(Icons.search)),
                )
                ],
              ),
            ),

            const SizedBox(height: 16,),
            Container(
              height: 80,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategorieTitle(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                  }),
            ),
            wallpaperList(wallpapers, context)
            ],),),
      ),
    );
  }
}

class CategorieTitle extends StatelessWidget {

  final String imgUrl, title;
  CategorieTitle({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategorieScreen(
                categorieName: title.toLowerCase(),
            )
        ));
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(right: 4),
        child: Stack(children: <Widget> [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.cover,)
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black26,
            ),
            height: 50, width: 100,
            child: Text(title, style: const TextStyle(color:  Colors.white, fontWeight: FontWeight.w500),),
          )
        ],),
      ),
    );
  }
}

