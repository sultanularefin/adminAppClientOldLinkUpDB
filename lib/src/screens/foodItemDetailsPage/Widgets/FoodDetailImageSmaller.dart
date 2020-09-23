import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class FoodDetailImageSmaller extends StatelessWidget {



  final String imageURLBig;
  final String foodItemName;
  FoodDetailImageSmaller(this.imageURLBig,this.foodItemName);

  @override
  Widget build(BuildContext context) {

    return



      Container(



            child: Hero(
              tag: foodItemName,
              child:
              ClipOval(
              clipper: MyClipper11(),
                child:CachedNetworkImage(
                  height:displayHeight(context)/4.6,
//                  width: displayWidth(context)/2.95,

                  imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                  fit: BoxFit.fill,
//
                  placeholder: (context, url) => new CircularProgressIndicator(),
                ),
              ),
            ),
      );

  }
}

class  MyClipper11 extends CustomClipper<Rect> {

  @override
  Rect getClip(Size size) {
//    return Rect.fromLTWH(left, top, width, height)
//  GOOD OPTION 1
//    return Rect.fromLTWH(-220, 0, 550, 550);

//    return Rect.fromCenter(center: Offset(0, 0),width:190,height:190);
//  GOOD OPTION 2
    return Rect.fromCircle(center: Offset(50, 80),radius:80);
//    return Rect.fromCircle(center: Offset(50, 120),radius:110);


  }
  @override
  bool shouldReclip(oldClipper) => false;
}


