import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:logger/logger.dart';

class FoodImageInShoppingCart extends StatelessWidget {
  final String imageURLBig;
  final String foodItemName;
  final List<NewIngredient> selectedIngredients;
  final double price;
  final int index;

  FoodImageInShoppingCart(this.imageURLBig, this.foodItemName,
      this.selectedIngredients, this.price, this.index);

  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );

    logger.e('price for one food Item ==> : $price');

    print('index = $index in shopping cart');
    return Container(
//      color: Color(0xffF4F6CE),
      color: Color(0xffFCF5E4),
      height: displayHeight(context) / 5.4,
      width: displayWidth(context) / 4.2,
      margin: EdgeInsets.fromLTRB(0, 0, 12, 0),

      child: Column(
        children: <Widget>[
          Container(
            width: displayWidth(context) / 4.2,
            child: Row(
              children: <Widget>[
                Container(
                  width: 110,
                  color: Color(0xffFCF5E4),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ClipOval(
                    clipper: MyClipper11(),
                    child: CachedNetworkImage(
                      height: displayHeight(context) / 8,
                      imageUrl: imageURLBig,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffFCF5E4),
                  child: Text(price.toStringAsFixed(2) + '\u20AC',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff707070),
                      )),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffFCF5E4),
            width: 160,
            child: foodItemName.length > 18
                ? Text('${foodItemName.substring(0, 16)}' + '...',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff707070),
                    ))
                : Text('$foodItemName',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    )),
          ),
          Container(
            color: Color(0xffFCF5E4),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: 160,
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: false,
              shrinkWrap: false,
              itemCount: selectedIngredients.length,
              itemBuilder: (_, int index) {
                return Text(
                  '${selectedIngredients[index].ingredientName}' + ', ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                    color: Color(0xff707070),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class MyClipper11 extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: Offset(30, 70), radius: 70);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class MyClipper12 extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: Offset(30, 70), radius: 70);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}
