
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseIngredientBloc.dart';
import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';
import 'package:linkupadminolddb/src/DataLayer/models/IngredientSubgroup.dart';
import 'package:linkupadminolddb/src/DataLayer/models/NewCategoryItem.dart';

import 'package:linkupadminolddb/src/DataLayer/models/NewIngredient.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:linkupadminolddb/src/screens/foodGallery/foodgalleryAdminHome2.dart';
import 'package:linkupadminolddb/src/utilities/screen_size_reducers.dart';



class CategoryItem {
  CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final Icon icon;
}



class AdminFirebaseIngredient extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

//  final Firestore firestore = Firestore.instance;

  AdminFirebaseIngredient({Key key, this.child}) : super(key: key);
  _AddDataState createState() => _AddDataState();

}


class _AddDataState extends State<AdminFirebaseIngredient> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddDataState({firestore});
  File _image;

  final _formKey = GlobalKey<FormState>();
  var onlyDigitsAndPoints = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
  Radius zero = Radius.circular(6.0);
//  Radius.circular(0.0);

  int _currentCategory= 0;
  bool _loadingState = false;


  Future getImage() async {

    var image = await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );

    print('_image initially: $_image');
    print('image at getImage: $image');

    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);




    blocAdminIngredientFBase.setImage(image);



//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    final FirebaseUser user = await _auth.currentUser();


    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = FirebaseAuth.instance.currentUser;




    blocAdminIngredientFBase.setUser(user.email);

    setState(() {
      _image = image;
    });
  }


  Widget _buildOneCheckBoxIngredientSubGroup(IngredientSubgroup ct, int index) {
    return Container(
        child: ct.isSelected ==true

            ? Container(
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFFE18E),
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child: Container(
//              alignment: Alignment.center,
              child:
              CheckboxListTile(
                  title: Text('${ct.ingredientSubgroupName}',
                    maxLines: 2,
                    style: TextStyle(


                      fontSize: 24,
                      fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                      color: Colors.black,
                      fontFamily: 'Itim-Regular',

                    ),),


//                  value: _itemData.passions[ItemData.PassionCooking],
                  value: ct.isSelected,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectSubgroupValue(index);

                  }

              ),



            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSubgroupValue(index);

            },
          ),
        )
            : Container(

          // margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
            // clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Container(

              child:

              CheckboxListTile(
//                  title: Text('${ct.ingredientSubgroupName}'),

                  title: Text('${ct.ingredientSubgroupName}',
                    maxLines: 2,
                    style: TextStyle(


                      fontSize: 24,
                      fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                      color: Colors.black,
                      fontFamily: 'Itim-Regular',

                    ),),

                  value: ct.isSelected,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectSubgroupValue(index);

                  }

              ),
            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSubgroupValue(index);

            },
          ),
        )
    );
  }


  Widget _buildOneCheckBoxIngredientOfFoodCategory(NewCategoryItem ct, int index) {
    return Container(
        child: ct.isSelected ==true

            ? Container(
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFFE18E),
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child: Container(
//              alignment: Alignment.center,
              child:
              CheckboxListTile(
                  title: Text('${ct.categoryName}'),
//                  value: _itemData.passions[ItemData.PassionCooking],
                  value: ct.isSelected,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectCategoryValue(index);

                  }

              ),



            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectCategoryValue(index);

            },
          ),
        )
            : Container(

          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
            // clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Container(

              child:

              CheckboxListTile(
                  title: Text('${ct.categoryName}'),

                  value: ct.isSelected,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectCategoryValue(index);

                  }

              ),
            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectCategoryValue(index);

            },
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {

    final blocAdminIngredientFBase =
    /*final blocAdminFoodFBase = */ BlocProvider.of<AdminFirebaseIngredientBloc>(context);


    print('at _loadingState == false in AdminFirebase Ingredient...');
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
              title: Text('Admin Ingredient Upload',

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey,
                ),


              ),
              backgroundColor: Color(0xffFFE18E),
            ),
//          appBar: AppBar(title: Text('Admin Firebase Ingredient')),
            body: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//              ....
              child: StreamBuilder<NewIngredient>(
                  stream: blocAdminIngredientFBase.thisIngredientItemStream, //null,
                  initialData: blocAdminIngredientFBase.getCurrentIngredientItem,
                  builder: (context, snapshot) {
                    final NewIngredient currentIngredient = snapshot.data;

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

                                          backgroundColor: Colors.blueGrey,
                                          radius: 130,


                                          child: new Container(

                                              height:100,
                                              width:180,

                                              child: Text('no ingredient image selected.',
                                                style: TextStyle(


                                                  fontSize: 24,
                                                  fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                  color: Colors.white,
                                                  fontFamily: 'Itim-Regular',

                                                ),

                                                textAlign: TextAlign.center,


                                              )

                                          )

                                          ,),
                                        ) : GestureDetector(
                                          onTap: () {
                                            getImage();

                                          }, child: new CircleAvatar(

                                            backgroundColor: Colors.lightBlueAccent,
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
                                        InputDecoration(labelText: 'Ingredient Name',

                                          labelStyle:TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.normal,
//                                                      color: Colors.white
//                    color: Colors.redAccent,
                                            fontFamily: 'Itim-Regular',

                                          ),
                                        ),
                                        validator: (value) {

                                          return value.isEmpty? 'please enter the ingredient Name.' : null;

                                        },


                                        // onSaved: (val) =>
                                        onChanged: (val) =>
                                            blocAdminIngredientFBase.setItemName(val),
                                      ),




                                      Container(
                                        height:80,
                                        margin: EdgeInsets.fromLTRB(0,10,0,10),
                                        color: Color(0xffFFE18E),
                                        child:

                                        Text('ingredient of food item category: ',

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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 20),

                                        child:



                                        StreamBuilder<List<NewCategoryItem>>(
                                          stream: blocAdminIngredientFBase.getCategoryMultiSelectControllerStream ,
                                          initialData:blocAdminIngredientFBase.getCategoryTypesForDropDown,
                                          builder: (context, snapshot) {

                                            final List<NewCategoryItem> allCategories = snapshot.data;


                                            return

                                              GridView.builder(
                                                itemCount: allCategories.length,
                                                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                  //Above to below for 3 not 2 Food Items:
                                                  maxCrossAxisExtent: 220,
                                                  mainAxisSpacing: 10, // H  direction
                                                  crossAxisSpacing: 20,
                                                  childAspectRatio: 200 / 110, /* (h/vertical)*/
                                                ),
                                                shrinkWrap: true,

//        reverse: true,
                                                itemBuilder: (_, int index) {

                                                  return _buildOneCheckBoxIngredientOfFoodCategory(
                                                      allCategories[index], index);
                                                },
                                              );


                                          }

                                          ,
                                        ),
                                      ),



                                      Container(
                                        height:80,
                                        margin: EdgeInsets.fromLTRB(0,10,0,10),
//                                                margin: EdgeInsets.fromLTRB(0,10,0,10),
//                                            color: Color(0xffFFE18E),
                                        child: Row(
                                          children: [
                                            Text('price: ',

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

                                            Container(
                                              width: displayWidth(context) / 3,
                                              child:




                                              TextFormField(
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[


//                                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter price';
                                                  }
                                                },
                                                textInputAction: TextInputAction.done,
//                                                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(

                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.
                                                      all(
                                                          zero

                                                      )),
                                                  hintText: 'price',
                                                  hintStyle:
                                                  TextStyle(color: Color(0xffFC0000), fontSize: 17),
                                                ),
                                                style: TextStyle(color: Color(0xffFC0000), fontSize: 16),
                                                onChanged: (text) {
                                                  print("price ....: $text");


                                                  final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);
                                                  blocAdminIngredientFBase.setPrice(text);

                                                },
                                                onTap: () {
                                                  print('..tapped for price input......');
                                                },
                                              ),
                                            ),





                                          ],
                                        ),
                                      ),

                                      Container(
                                        height:80,
                                        margin: EdgeInsets.fromLTRB(0,10,0,10),
                                        color: Color(0xffFFE18E),
                                        child: Text('subGroup....: ',

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
                                        height:200,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 20),

                                        child:
                                        StreamBuilder<List<IngredientSubgroup>>(
                                          stream: blocAdminIngredientFBase.getIngredientGroupsControllerStream,
                                          initialData:blocAdminIngredientFBase.getIngredientTypes,
                                          builder: (context, snapshot) {

                                            final List<IngredientSubgroup> allIngredientSubGroups =
                                                snapshot.data;
                                            return
                                              GridView.builder(
                                                itemCount: allIngredientSubGroups.length,
                                                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                  //Above to below for 3 not 2 Food Items:
                                                  maxCrossAxisExtent: 250,
                                                  mainAxisSpacing: 20, // H  direction
                                                  crossAxisSpacing: 10,
                                                  childAspectRatio: 240 / 60, /* (h/vertical)*/
                                                ),
                                                shrinkWrap: true,

//        reverse: true,
                                                itemBuilder: (_, int index) {

                                                  return _buildOneCheckBoxIngredientSubGroup(
                                                      allIngredientSubGroups[index], index);
                                                },
                                              );


                                          }

                                          ,
                                        ),
                                      ),



                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: RaisedButton(
                                              color: Colors.yellowAccent,
                                              onPressed: () async {
                                                final form = _formKey.currentState;

                                                print('form: $_formKey.currentState');
                                                print('at onPressed ');


                                                //   the method 'validate' isn't defined for the class 'State'




                                                final FirebaseAuth _auth = FirebaseAuth.instance;
                                                final User user = FirebaseAuth.instance.currentUser;




//                                                    final FirebaseAuth _auth = FirebaseAuth.instance;
//                                                    final FirebaseUser user = await _auth.currentUser();


                                                blocAdminIngredientFBase.setUser(user.email);


                                                if (form.validate()) {
                                                  form.save();

                                                  _scaffoldKey.currentState.showSnackBar(
                                                    new SnackBar(duration: new Duration(seconds: 5), content:Container(
                                                      child:
                                                      new Row(
                                                        children: <Widget>[
                                                          new CircularProgressIndicator(),
                                                          new Text("uploading ingredient data....",style:
                                                          TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    )),);

                                                  int statusOfUpload =  await blocAdminIngredientFBase.saveIngredientItem();


                                                  if (statusOfUpload == 0) {
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

                                                  else if (statusOfUpload == 4) {
                                                    _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("please select extra ingredient of food item category.",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);
                                                  }

                                                  else if (statusOfUpload == 5) {
                                                    _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("please select ingredient subgroup",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);
                                                  }
                                                  else{
                                                    _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("success check firestore and storage...",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);
                                                  }

                                                }
                                                else {
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
                                              },
                                              child: Text('Save',
                                                style: TextStyle(
                                                    fontSize: 20, color: Colors
                                                    .lightBlueAccent),)
                                          )
                                      ),
                                    ]

                                )

                            )
                    );


                  }
              ),
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

}


class SpinkitTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpinKit Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: SafeArea(

          child: Center(
            child: LinearProgressIndicator(),

            //WorkspaceSpinkit(),
          ),
        ),
      ),
    );

  }
}
