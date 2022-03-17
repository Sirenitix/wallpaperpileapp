import 'dart:typed_data';
import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imageUrl;
  ImageView({@required this.imageUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

   var filePath;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: widget.imageUrl,
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imageUrl, fit: BoxFit.cover,)),
        ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:<Widget>[
                GestureDetector(
                  onTap: (){
                    _save();
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1C1B1B).withOpacity(0.8),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration:  BoxDecoration(
                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0x36ffffff),
                                  Color(0x0fffffff)
                                ]
                            )
                        ),
                        child: Column(children: const <Widget>[
                          Text("Set Wallpaper", style: TextStyle(
                              fontSize: 16, color: Colors.white70
                          ),),
                          Text("Image will be saved in the galary", style: TextStyle(
                              fontSize: 10, color: Colors.white70
                          ),)
                        ],),
                      ),
                    ],
                  ),
                ),
                  const SizedBox(height: 16,),
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);},
                    child: const Text("Cancel", style: TextStyle(color: Colors.white),)),
                  const SizedBox(height: 50,)
              ],),
            )
      ],),
    );
  }

  _save() async {

    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }


}
