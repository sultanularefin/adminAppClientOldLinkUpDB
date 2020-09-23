
// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';


import 'package:linkupadminolddb/src/DataLayer/models/CheeseItem.dart';
import 'package:linkupadminolddb/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:linkupadminolddb/src/DataLayer/models/NewCategoryItem.dart';
import 'package:linkupadminolddb/src/DataLayer/models/NewIngredient.dart';
import 'package:linkupadminolddb/src/DataLayer/models/SauceItem.dart';

// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:linkupadminolddb/src/BLoC/bloc.dart';
import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';
import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseFoodBloc.dart';
//import '../../BLoC/bloc_provider.dart';
//import './../../BLoC/AdminFirebaseFoodBloc.dart';
import 'package:logger/logger.dart';
import 'package:linkupadminolddb/src/utilities/screen_size_reducers.dart';

//import 'package:fluttercrud/src/shared/category_Constants.dart' as CategoryItems;


//final Firestore firestore = Firestore();


/*
class CategoryItem {
  CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final String shortName;
  final Icon icon;

}

*/

//class Item {
//  const Item(this.name,this.icon);
//  final String name;
//  final Icon icon;
//}


class AdminFirebaseFood extends StatefulWidget {
//  AdminFirebaseFood({this.firestore});

  final Widget child;

//  final Firestore firestore = Firestore.instance;

  AdminFirebaseFood({Key key, this.child}) : super(key: key);
  _AddDataState createState() => _AddDataState();

}


class _AddDataState extends State<AdminFirebaseFood> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddDataState({firestore});
  File _image;


  final _formKey = GlobalKey<FormState>();

  int _currentCategory= 0;
  bool _loadingState = false;
  String token= '';




//  void setCategoryValue(int categoryValue){
//
//    setState(() {
//      _currentCategory =categoryValue;
//    });
//
//  }



  Widget _buildOneCheckBoxCheeseItem(CheeseItem ct, int index,String token) {

    print('at _buildOneCheckBoxCheeseItem .... ${ct.cheeseItemName}  ct.isSelected ${ct.isSelected}');

//    return Text('${ct.cheeseItemName}');

    return Container(
        child:  ct.isSelected ==true


            ? Container(
//          color: Colors.lightGreenAccent,
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          width: displayWidth(context) / 2.8,
          child: InkWell(


            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child:
              Column(
                children: [

                  Container(
                    padding: EdgeInsets.fromLTRB(0,12,0,0),
                    width: displayWidth(context) /  9,
                    height: displayWidth(context) / 8,
                    child:
                    ClipOval(
                      child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                        imageUrl: ct.imageURL + token,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                      ),
                    ),
                  ),

//                  Text('${ct.ingredientName}'),

                  Container(
//                    color:Colors.red,
                    child: CheckboxListTile(
                        title:
                        // Text('${ct.cheeseItemName}'),

                        Text(
                          ((ct.cheeseItemName == null) ||
                              (ct.cheeseItemName.length == 0))
                              ? ''
                              : ct.cheeseItemName.length > 19
                              ? ct.cheeseItemName
                              .substring(0, 15) +
                              '...'
                              : ct.cheeseItemName,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),

                        value:  ct.isSelected,
                        onChanged: (val) {


                          final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                          blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

                        }

                    ),
                  ),

                ],
              ),



            ),
            onTap: () {
              print('....at onTap () 1 ');

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

            },
          ),
        )
            : Container(
//          color: Colors.blue,
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: InkWell(

            child: Container(

              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child:

              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0,12,0,0),
                    width: displayWidth(context) / 9,
                    height: displayWidth(context) /8,
                    child:
                    ClipOval(
                      child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                        imageUrl: ct.imageURL + token,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                      ),
                    ),
                  ),


                  Container(
//                    color:Colors.red,
                    child: CheckboxListTile(
                        title:
                        //Text('${ct.cheeseItemName}'),

                        Text(
                          ((ct.cheeseItemName == null) ||
                              (ct.cheeseItemName.length == 0))
                              ? ''
                              : ct.cheeseItemName.length > 19
                              ? ct.cheeseItemName
                              .substring(0, 15) +
                              '...'
                              : ct.cheeseItemName,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),

                        value:  ct.isSelected,
                        onChanged: (val) {


                          final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                          blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

                        }

                    ),
                  ),

//                  Text('${ct.ingredientName}')

                ],
              ),
            ),
            onTap: () {
              print('....at onTap () 2 ');
              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

            },
          ),
        ));


  }




  Widget _buildOneCheckBoxIngredient(NewIngredient ct, int index, String token) {
    return Container(
        child: ct.isDefault ==true


            ? Container(
//          color: Colors.lightGreenAccent,
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          width: displayWidth(context) / 2.8,
          child: InkWell(


            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child:
              Column(
                children: [

                  Container(
                    padding: EdgeInsets.fromLTRB(0,12,0,0),
                    width: displayWidth(context) /  9,
                    height: displayWidth(context) / 8,
                    child:
                    ClipOval(
                      child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                        imageUrl: ct.imageURL + token,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                      ),
                    ),
                  ),

//                  Text('${ct.ingredientName}'),

                  Container(
//                    color:Colors.red,
                    child: CheckboxListTile(
                        title:

                        Text(
                          ((ct.ingredientName == null) ||
                              (ct.ingredientName.length == 0))
                              ? ''
                              : ct.ingredientName.length > 19
                              ? ct.ingredientName
                              .substring(0, 15) +
                              '...'
                              : ct.ingredientName,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),

                        value: ct.isDefault,
                        onChanged: (val) {


                          final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                          blocAdminIngredientFBase.toggoleMultiSelectIngredientValue(index);

                        }

                    ),
                  ),

                ],
              ),



            ),
            onTap: () {
              print('....at onTap () 1 ');

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectIngredientValue(index);

            },
          ),
        )
            : Container(
//          color: Colors.blue,
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: InkWell(

            child: Container(

              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child:

              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0,12,0,0),
                    width: displayWidth(context) / 9,
                    height: displayWidth(context) /8,
                    child:
                    ClipOval(
                      child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                        imageUrl: ct.imageURL +token,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                      ),
                    ),
                  ),


                  Container(
//                    color:Colors.red,
                    child: CheckboxListTile(
                        title:
                        Text(
                          ((ct.ingredientName == null) ||
                              (ct.ingredientName.length == 0))
                              ? ''
                              : ct.ingredientName.length > 19
                              ? ct.ingredientName
                              .substring(0, 15) +
                              '...'
                              : ct.ingredientName,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
//                        Text('${ct.ingredientName}'),

                        value: ct.isDefault,
                        onChanged: (val) {


                          final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                          blocAdminIngredientFBase.toggoleMultiSelectIngredientValue(index);

                        }

                    ),
                  ),

//                  Text('${ct.ingredientName}')

                ],
              ),
            ),
            onTap: () {
              print('....at onTap () 2 ');
              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectIngredientValue(index);

            },
          ),
        ));


  }




  Widget _buildOneCheckBoxSauceItem(SauceItem ct, int index, String token) {

    print('.....token : $token');
    return Container(
        child: ct.isSelected ==true


            ? Container(
//          color: Colors.lightGreenAccent,
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          width: displayWidth(context) / 2.8,
          child: InkWell(


            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child:
              Column(
                children: [

                  Container(
                    padding: EdgeInsets.fromLTRB(0,12,0,0),
                    width: displayWidth(context) /  9,
                    height: displayWidth(context) / 8,
                    child:
                    ClipOval(
                      child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                        imageUrl: ct.imageURL + token,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                      ),
                    ),
                  ),

//                  Text('${ct.ingredientName}'),

                  Container(
//                    color:Colors.red,
                    child: CheckboxListTile(
                        title:
//                        Text('${ct.sauceItemName}'),

                        Text(
                          ((ct.sauceItemName == null) ||
                              (ct.sauceItemName.length == 0))
                              ? ''
                              : ct.sauceItemName.length > 19
                              ? ct.sauceItemName
                              .substring(0, 15) +
                              '...'
                              : ct.sauceItemName,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),

                        value: ct.isSelected,
                        onChanged: (val) {


                          final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                          blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

                        }

                    ),
                  ),

                ],
              ),



            ),
            onTap: () {
              print('....at onTap () 1 ');

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

            },
          ),
        )
            : Container(
//          color: Colors.blue,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 0.2,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: InkWell(

            child: Container(

              child:

              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0,12,0,0),
                    width: displayWidth(context) / 9,
                    height: displayWidth(context) /8,
                    child:
                    ClipOval(
                      child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                        imageUrl: ct.imageURL + token,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                      ),
                    ),
                  ),


                  Container(
//                    color:Colors.red,
                    child: CheckboxListTile(
                        title:
//                        Text('${ct.sauceItemName}'),

                        Text(
                          ((ct.sauceItemName == null) ||
                              (ct.sauceItemName.length == 0))
                              ? ''
                              : ct.sauceItemName.length > 19
                              ? ct.sauceItemName
                              .substring(0, 15) +
                              '...'
                              : ct.sauceItemName,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),

                        value: ct.isSelected,
                        onChanged: (val) {


                          final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                          blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

                        }

                    ),
                  ),

//                  Text('${ct.ingredientName}')

                ],
              ),
            ),
            onTap: () {
              print('....at onTap () 2 ');
              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

            },
          ),
        ));


  }



  Future getImage() async {


    final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);

    var image = await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );


    print('_image initially: $_image');
    print('image at getImage: $image');

//    print('_currentCategory: $_currentCategory');



    blocAdminFoodFBase.setImage(image);





//    _itemData.setUser =user.email;


    setState(() {
      _image = image;
    });
  }

//  final Firestore firestore = Firestore.instance;

//  CollectionReference get messages => firestore.collection('messages');

  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );

    logger.w('at build of AdminFirebaseFood');


    final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);


    print('at _loadingState == false in AdminFirebase food...');
    return SafeArea(
      child: Theme(
        data: ThemeData(primaryIconTheme: IconThemeData(

          color: Colors.blueGrey,
          // size: 40,

        ),
        ),// use this
        child: new Scaffold(
            key:_scaffoldKey,
            appBar: AppBar(
              title: Text('Admin Food Upload',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey,
                ),

              ),
              backgroundColor: Color(0xffFFE18E),
            ),
            body: Container(
                padding:
                const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 10.0),
                child: StreamBuilder<FoodItemWithDocID>(
                  stream: blocAdminFoodFBase.thisFoodItemStream, //null,
                  initialData: blocAdminFoodFBase.getCurrentFoodItem,
                  builder: (context, snapshot) {
                    final FoodItemWithDocID currentFood = snapshot.data;

                    token = currentFood.urlAndTokenForStorageImage;
                    _currentCategory = currentFood.categoryIndex == null?0:currentFood.categoryIndex;

                    return Builder(
                        builder: (context) =>
                            Form(
                                key: _formKey,
                                child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      new Container(
                                        child: _image == null
                                            ?
                                        GestureDetector(
                                          onTap: () {
                                            getImage();
                                          }, child: new CircleAvatar(

                                            backgroundColor: Colors.grey,
                                            radius: 120.0,

                                            child: new Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    style: BorderStyle.solid,
                                                    width: 0.2,
                                                  ),
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                ),
                                                padding: const EdgeInsets.all(0.0),
                                                child: new Container(
                                                  height:100,
                                                  width:180,

                                                  child: Text('no foodItem image selected.',

                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(


                                                      fontSize: 24,
                                                      fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                      color: Colors.redAccent,
                                                      fontFamily: 'Itim-Regular',

                                                    ),
                                                  ),
                                                )

                                            )
                                        ),
                                        ) : GestureDetector(
                                          onTap: () {
                                            getImage();

                                          }, child: new CircleAvatar(

//                                          backgroundColor: Colors.lightBlueAccent,
                                            radius: 80.0,

                                            child: new Container(
                                              padding: const EdgeInsets.all(0.0),
                                              child: Image.file(_image),

                                            )

                                        ),
                                        ),
                                      ),




                                      TextFormField(
                                        decoration:
                                        InputDecoration(labelText: 'foodItem Name',

                                          labelStyle:TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                            color: Colors.redAccent,
                                            fontFamily: 'Itim-Regular',

                                          ),
                                        ),
                                        validator: (value) {
                                          return value.isEmpty? 'please enter the fooditem name.' : null;
//                                          if (value.isEmpty) {
//                                            return 'Please enter the foodItem Name';
//                                          }
                                        },
                                        onChanged: (val) =>
                                            blocAdminFoodFBase.setItemName(val),

                                      ),

                                      /*
                                        Container(child:Text('${currentFood.sequenceNo}',

                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                              color: Colors.redAccent,
                                              fontFamily: 'Itim-Regular',

                                            )
                                        ),
                                        ),

                                        */

                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 20),

                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.fromLTRB(
                                                    0, 20, 0, 20),
                                                child: Text('food Category: ',
                                                  style: TextStyle(fontSize: 20,
                                                      color: Colors
                                                          .lightBlueAccent),),
                                              ),


                                              SizedBox(width: 10),

                                              Container(

                                                width: displayWidth(context)/2,


                                                child:


                                                StreamBuilder<List<NewCategoryItem>>(
                                                  stream: blocAdminFoodFBase.getCategoryDropDownControllerStream,
                                                  initialData: blocAdminFoodFBase.getCategoryTypesForDropDown,
                                                  builder: (context, snapshot) {

                                                    final List<NewCategoryItem> allCategories = snapshot.data;


//                                                    allCategories


//                                                              _currentCategory=cu

                                                    return DropdownButtonFormField(

                                                      value: allCategories[_currentCategory]
                                                            .sequenceNo,
//                                                        value: _currentCategory ,
//                                                        _currentCategory
//                                                        value: _currentCategory !=0 ?
//                                                        allCategories[_currentCategory]
//                                                            .sequenceNo
//                                                            : allCategories[0].sequenceNo,

                                                        items: allCategories.map((oneItem) {
                                                          return DropdownMenuItem(


                                                            value: oneItem.sequenceNo,
                                                            child: Row(
                                                              children: <Widget>[
//                                                        oneItem.icon,
                                                                SizedBox(width: 10,),
                                                                Text(
                                                                  oneItem.categoryName,
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
//                                          child: Text(oneItem.name),
                                                          );
                                                        }).toList(),
                                                        onChanged: (val)  {

                                                          blocAdminFoodFBase
                                                              .setCategoryValueFoodItemUPload(val);


                                                        }

                                                    );
                                                  }

                                                  ,
                                                ),
                                              ),
                                            ]
                                        ),
//                            Text('Subscribe'),
                                      ),

//
/*

                                      SwitchListTile(
                                          title: const Text('Is Hot'),
                                          value: currentFood.isHot, //_itemData.isHot,
                                          onChanged: (bool val) =>
                                              blocAdminFoodFBase.setIsHot(val)

                                      ),


                                      SwitchListTile(
                                        title: const Text('Is Available'),
                                        value:currentFood.isAvailable,
                                        onChanged: (bool val) =>
                                            setState(() =>
                                                blocAdminFoodFBase.setIsAvailable(val)),
//    _itemData.isAvailable = val)
                                      ),

                                      */

                                      // Cooking checkBox
                                      /*

                                  CheckboxListTile(
                                      title: const Text('Cooking'),
                                      value: _itemData.passions[ItemData.PassionCooking],
                                      onChanged: (val) {
                                        setState(() =>
                                        _itemData.passions[ItemData.PassionCooking] = val);
                                      }),

                                  */




                                      Container(
                                        height:60,
                                        color: Color(0xffFFE18E),
                                        child: Text('select ingredients for food: ',

                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                              color: Colors.redAccent,
                                              fontFamily: 'Itim-Regular',

                                            )
                                        ),
                                      ),


                                      Container(
                                        height: displayHeight(context) / 3,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 20),

                                        child:


                                        StreamBuilder<List<NewIngredient>>(
                                          stream: blocAdminFoodFBase.getExtraIngredientItemsStream ,
                                          initialData:blocAdminFoodFBase.getAllExtraIngredients,
                                          builder: (context, snapshot) {
                                            final List<NewIngredient> allNewIngredients = snapshot.data;
                                            logger.w(' allNewIngredients.length: ${ allNewIngredients.length}');
                                            return

                                              GridView.builder(
                                                itemCount: allNewIngredients.length,
                                                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                  //Above to below for 3 not 2 Food Items:
                                                  maxCrossAxisExtent: 160,

                                                  crossAxisSpacing: 23,
                                                  childAspectRatio: 150 / 195, /* (h/vertical)*/
                                                  mainAxisSpacing: 23,


                                                ),
                                                shrinkWrap: false,

//        reverse: true,
                                                itemBuilder: (_, int index) {

                                                  return _buildOneCheckBoxIngredient(
                                                      allNewIngredients[index], index,token);
                                                },
                                              );


                                          }

                                          ,
                                        ),
                                      ),



                                      // select cheese begins here....

                                      Container(

                                        height:60,
                                        color: Color(0xffFFE18E),
                                        child: Text('select cheese for food: ',

                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                              color: Colors.redAccent,
                                              fontFamily: 'Itim-Regular',

                                            )
                                        ),
                                      ),


                                      Container(
                                        height: displayHeight(context)/3.5,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 20),

                                        child:


                                        StreamBuilder<List<CheeseItem>>(
                                          stream: blocAdminFoodFBase.getCheeseItemsStream ,
                                          initialData:blocAdminFoodFBase.getAllCheeseItemsAdminFoodUpload,
                                          builder: (context, snapshot) {
                                            final List<CheeseItem> allCheeseItems = snapshot.data;

                                            logger.w('allCheeseItems.length: ${allCheeseItems.length}');

                                            return

                                              GridView.builder(
                                                itemCount: allCheeseItems.length,
                                                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                  //Above to below for 3 not 2 Food Items:
                                                  maxCrossAxisExtent: 160,
                                                  crossAxisSpacing: 23,
                                                  childAspectRatio: 150 / 195, /* (h/vertical)*/
                                                  mainAxisSpacing: 23,
                                                ),
                                                shrinkWrap: false,

//        reverse: true,
                                                itemBuilder: (_, int index) {

                                                  return _buildOneCheckBoxCheeseItem(
                                                      allCheeseItems[index], index,token);
                                                },
                                              );


                                          }

                                          ,
                                        ),
                                      ),


                                      // select cheese ends here....


                                      // select sauce begins here....
                                      Container(

                                        height:60,
                                        color: Color(0xffFFE18E),
                                        child: Text('select Sauces for food: ',

                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                              color: Colors.redAccent,
                                              fontFamily: 'Itim-Regular',

                                            )
                                        ),
                                      ),


                                      Container(
                                        height: displayHeight(context) / 5,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 20),

                                        child:
                                        StreamBuilder<List<SauceItem>>(
                                          stream: blocAdminFoodFBase.getSauceItemsStream ,
                                          initialData:blocAdminFoodFBase.getAllSauceItemsFoodUploadAdmin,
                                          builder: (context, snapshot) {
                                            final List<SauceItem> allSauces = snapshot.data;

                                            logger.w('allSauces.length: ${allSauces.length}');
                                            return
                                              GridView.builder(
                                                itemCount: allSauces.length,
                                                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                  //Above to below for 3 not 2 Food Items:
                                                  maxCrossAxisExtent: 160,
                                                  crossAxisSpacing: 23,
                                                  childAspectRatio: 150 / 195, /* (h/vertical)*/
                                                  mainAxisSpacing: 23,
                                                ),

                                                shrinkWrap: false,
//        reverse: true,
                                                itemBuilder: (_, int index) {

                                                  return _buildOneCheckBoxSauceItem(
                                                      allSauces[index], index,token);
                                                },
                                              );


                                          }

                                          ,
                                        ),
                                      ),

                                      // select sauce ends here....


                                      Container(
                                          height: 100,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: RaisedButton(
                                              color: Colors.yellowAccent,
                                              child: Text('Save',
                                                style: TextStyle(
                                                    fontSize: 40, color: Colors
                                                    .lightBlueAccent),),
                                              onPressed: () async {

//                                                    911_1

                                                final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                                                final form = _formKey.currentState;

                                                print('form: $_formKey.currentState');
                                                print('at onTap ');

//                                              final FirebaseAuth _auth = FirebaseAuth.instance;
//                                              final FirebaseUser user = await _auth.currentUser();



                                                final FirebaseAuth _auth = FirebaseAuth.instance;
                                                final User user = FirebaseAuth.instance.currentUser;



                                                blocAdminFoodFBase.setUser(user.email);


                                                //   the method 'validate' isn't defined for the class 'State'

                                                if (form.validate()) {
                                                  form.save();

                                                  _scaffoldKey.currentState.showSnackBar(
                                                    new SnackBar(duration: new Duration(seconds: 5), content:Container(
                                                      child:
                                                      new Row(
                                                        children: <Widget>[
                                                          new CircularProgressIndicator(),
                                                          new Text("uploading food data....",style:
                                                          TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    )),);

//                                            showDialog(
//                                                context: context,
//                                                builder: (BuildContext context) {
//                                                  return Center(child: CircularProgressIndicator(),);
//                                                });

                                                  /*
                                                    if (_image == null) {
                                                      _showDialogImageNotAdded(context);
                                                      return Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AdminFirebaseFood()));
                                                    }

                                                    */



                                                  /*
                                                          await _itemData
                                                              .save();

                                                          // invokes the method in ItemData class.
*/
                                                  int successValue=  await blocAdminFoodFBase.saveFoodItem();





                                                  if(successValue==0){


                                                    _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("Something went wrong, Try VPN.",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);
                                                  }


                                                  else if(successValue==4){


                                                    _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("please select ingredients for food.",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);
                                                  }

                                                  else if(successValue==5){


                                                    _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("please select cheeses for food",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);
                                                  }
                                                  // }
                                                  else {

                                                    _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("food item uploaded in DB....",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);





                                                  }
                                                }
                                                else{

                                                  Scaffold.of(context)
                                                      .showSnackBar(
                                                    SnackBar(content: Row(
                                                      children: [
                                                        Icon(Icons.thumb_up),
                                                        SizedBox(width: 20),
                                                        Expanded(child: Text(
                                                          "Please check the fields",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .lightBlueAccent,
                                                              backgroundColor: Colors
                                                                  .deepOrange),
                                                        ),),
                                                      ],),
                                                      duration: Duration(seconds: 4),
                                                    ),
                                                  );
                                                }

                                              }

                                          )
                                      ),
                                    ]

                                )

                            )
                    );

                  },
                )
            )
        ),
      ),
    );

  }
  _showDialog(BuildContext context) {

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  _showDialogImageNotAdded(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Please Add an Image.')));
  }

/*
  _showSpinkit (BuildContext context) {
    final spinkit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );

    return spinkit;
  }

  */




}

