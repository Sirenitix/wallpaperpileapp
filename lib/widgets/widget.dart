import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperpileapp/model/wallpaper_model.dart';
import 'package:wallpaperpileapp/views/image.dart';

Widget brandName(){
  return RichText(
    text:  const TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black)),
        TextSpan(text: 'Pile', style: TextStyle(color: Colors.purple)),
      ],
    ),
  );
}

Widget wallpaperList(List<WallpaperModel> wallpapers, context){
  return Container(
    padding:  const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        children: wallpapers.map((wallpaper) {
          return GridTile(
             child: GestureDetector(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) => ImageView(imageUrl: wallpaper.src.portrait)));
               },
               child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(wallpaper.src.portrait, fit: BoxFit.cover)),
           ),
            ),
             ),
          );
        }).toList(),
    ),
  );
}