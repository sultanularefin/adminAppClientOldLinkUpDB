
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseOLDCategoryBloc.dart';
//import 'package:linkupadminolddb/src/BLoC/AdminFirebaseIngredientBloc.dart';
import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';

//import 'package:linkupadminolddb/src/DataLayer/models/IngredientSubgroup.dart';
//import 'package:linkupadminolddb/src/DataLayer/models/OldCategoryItem.dart';

//import 'package:linkupadminolddb/src/DataLayer/models/NewIngredient.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkupadminolddb/src/DataLayer/models/OldCategoryItem.dart';


import 'package:linkupadminolddb/src/utilities/screen_size_reducers.dart';



class CategoryItem {
  CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final Icon icon;
}



class AdminFirebaseCheese extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

//  final Firestore firestore = Firestore.instance;

  AdminFirebaseCheese({Key key, this.child}) : super(key: key);
  _AddDataState createState() => _AddDataState();

}


class _AddDataState extends State<AdminFirebaseCheese> {

  final GlobalKey<ScaffoldState> _scaffoldKeyCategoryItemAdmin = new GlobalKey<ScaffoldState>();

//  _AddDataState({firestore});
  PickedFile _image;
  // File _image2;

  final _formKey = GlobalKey<FormState>();
  var onlyDigitsAndPoints = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
  Radius zero = Radius.circular(2.0);
//  Radius.circular(0.0);

  int _currentCategory= 0;
  bool _loadingState = false;

  TextEditingController categoryEditingController = new TextEditingController();
  TextEditingController shortCategoryEditingController = new TextEditingController();
  // TextEditingController usernameEditingController =  new TextEditingController();



  // return (currentOldCategory.categoryName=='')'category item name':,


  Future getImage() async {



    // --a1

    // File _image;
    // final picker = ImagePicker();
    //
    // Future getImage() async {
    //   final pickedFile = await picker.getImage(source: ImageSource.camera);
    //
    //   setState(() {
    //     if (pickedFile != null) {
    //       _image = File(pickedFile.path);
    //     } else {
    //       print('No image selected.');
    //     }


    // --a1
    final picker = ImagePicker();

    PickedFile image = await picker.getImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );

    print('_image initially: $_image');
    print('image at getImage: $image');

    // print('image at getImage: ${image.maxWidth}');

    final blocAdminCategoryFBase = BlocProvider.of<AdminFirebaseOLDCategoryBloc>(context);



    blocAdminCategoryFBase.setImage(image);



//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    final FirebaseUser user = await _auth.currentUser();


    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = FirebaseAuth.instance.currentUser;

    blocAdminCategoryFBase.setUser(user.email);


    setState(() {
      _image = image;
      // _image2 = image.path
    });



  }



  @override
  Widget build(BuildContext context) {

    final blocAdminCategoryFBase =
    /*final blocAdminFoodFBase = */ BlocProvider.of<AdminFirebaseOLDCategoryBloc>(context);


    print('at _loadingState == false in AdminFirebase Ingredient...');
    return SafeArea(
      child: Theme(
        data: ThemeData(primaryIconTheme: IconThemeData(

          color: Colors.blueGrey,
          // size: 40,

        ),
        ),// use this
        child: new Scaffold(
            key:_scaffoldKeyCategoryItemAdmin,
            appBar: AppBar(
              title: Text('Admin Category Select and image Upload',
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
              child: StreamBuilder<OldCategoryItem>(
                  stream: blocAdminCategoryFBase.thisOldCategoryItemStream, //null,
                  initialData: blocAdminCategoryFBase.getCurrentOldCategoryItem,
                  builder: (context, snapshot) {
                    final OldCategoryItem currentOldCategory = snapshot.data;


                    if(currentOldCategory.categoryName==''){
                      categoryEditingController.clear();
                    }

                    if(currentOldCategory.fireStoreFieldName==''){
                      shortCategoryEditingController.clear();
                    }


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

                                                child: Text('no category image selected.',
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


                                        ),
                                        ) : GestureDetector(
                                          onTap: () {
                                            getImage();

                                          }, child: new CircleAvatar(

                                            backgroundColor: Colors.lightBlueAccent,
                                            radius: 80.0,

                                            child: new Container(
                                              padding: const EdgeInsets.all(0.0),
                                              // child: Image.file(_image),
                                              child: Image.file(File(_image.path)),

                                              // return Image.file(File(_imageFile.path));

                                            )

                                        ),
                                        ),
                                      ),


                                      /*
                                      TextFormField(
                                        decoration:
                                        InputDecoration(labelText:'category item name',
                                          labelStyle:TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                            color: Colors.redAccent,
                                            fontFamily: 'Itim-Regular',

                                          ),
                                        ),

                                        controller: categoryEditingController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter the cheese Name';
                                          }
                                        },

                                        onChanged: (text) {
                                          print("price ....: $text");


                                          final blocAdminIngredientFBase =
                                          BlocProvider.of<AdminFirebaseOLDCategoryBloc>(context);
                                          // blocAdminIngredientFBase.setPrice(text);

                                          // blocAdminCategoryFBase.setShortCategoryName(text);
                                          blocAdminCategoryFBase.setCategoryName(text);

                                        },


                                        // onSaved: (val) =>
                                        // onChanged: (val) =>
                                        //     blocAdminCategoryFBase.setCategoryName(value),
                                      ),



                                      */

                                      /*
                                      SizedBox(height: 50),

                                      Container(

                                        height:60,
                                        child: Row(
                                          children: [
                                            Text('Hint: jauheliha_kebab_vartaat: ==>',

                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 34,
                                                  fontWeight: FontWeight.normal,
//                                                      color: Colors.white
//                                                     color: Colors.redAccent,
                                                  color: Colors.blueGrey,
                                                  fontFamily: 'Itim-Regular',

                                                )
                                            ),

                                            Container(
                                              width: displayWidth(context) / 3,
                                              child:Text('jauheliha_kebab_vartaat',

                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 34,
                                                    fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                    color: Colors.blueGrey,
                                                    fontFamily: 'Itim-Regular',

                                                  )
                                              ),

                                            ),





                                          ],
                                        ),
                                      ),


                                      */

                                      /*
                                      Container(

                                        height:60,
                                        child: Row(
                                          children: [
                                            Text('short category name: ',

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

                                                //---

                    /*
                                                decoration: InputDecoration(

                                                  border: OutlineInputBorder(borderRadius: BorderRadius.
                                                  all(
                                                      zero

                                                  )),
                                                  hintText: 'short category name.',
                                                  hintStyle:
                                                  TextStyle(color: Color(0xffFC0000), fontSize: 17),
                                                ),

                                                */

                                                decoration:
                                                InputDecoration(labelText:'short category name.',
                                                  labelStyle:TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                    color: Colors.redAccent,
                                                    fontFamily: 'Itim-Regular',

                                                  ),
                                                ),

                                                controller: shortCategoryEditingController,
                                                //---

                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[

                                                ],
                                                textInputAction: TextInputAction.done,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'please enter short category name to be used in firestore.';
                                                  }
                                                },


//                                                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                                                textAlign: TextAlign.center,

                                                style: TextStyle(color: Color(0xffFC0000), fontSize: 16),
                                                onChanged: (text) {
                                                  print("price ....: $text");


                                                  final blocAdminIngredientFBase =
                                                  BlocProvider.of<AdminFirebaseOLDCategoryBloc>(context);
                                                  // blocAdminIngredientFBase.setPrice(text);

                                                  blocAdminCategoryFBase.setShortCategoryName(text);

                                                },
                                                onTap: () {
                                                  print('..tapped for price input......');
                                                },
                                              ),
                                            ),





                                          ],
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


                                                StreamBuilder<List<OldCategoryItem>>(
                                                  stream: blocAdminCategoryFBase.getCategoryDropDownControllerStream,
                                                  initialData: blocAdminCategoryFBase.getCategoryTypesForDropDown,
                                                  builder: (context, snapshot) {

                                                    final List<OldCategoryItem> allCategories = snapshot.data;


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

                                                          blocAdminCategoryFBase.setCategoryValueFoodItemUPload(val);


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


                                      SizedBox(height: 100),

                                      Container(
                                          height:80,
//                                        color:Colors.pink,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: RaisedButton(
                                              color: Colors.lightGreenAccent,
                                              onPressed: () async {
                                                final form = _formKey.currentState;

                                                print('form: $_formKey.currentState');
                                                print('at onPressed ');


                                                //   the method 'validate' isn't defined for the class 'State'


//                                              final FirebaseAuth _auth = FirebaseAuth.instance;
//                                              final FirebaseUser user = await _auth.currentUser();


                                                final FirebaseAuth _auth = FirebaseAuth.instance;
                                                final User user = FirebaseAuth.instance.currentUser;



                                                blocAdminCategoryFBase.setUser(user.email);


                                                if (form.validate()) {
                                                  form.save();

                                                  _scaffoldKeyCategoryItemAdmin.currentState.showSnackBar(
                                                    new SnackBar(duration: new Duration(seconds: 5), content:Container(
                                                      child:
                                                      new Row(
                                                        children: <Widget>[
                                                          new CircularProgressIndicator(),
                                                          new Text("uploading category Item data....",style:
                                                          TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    )),);

                                                  int loginRequiredStatus =  await blocAdminCategoryFBase.save();


                                                  if (loginRequiredStatus == 0) {
                                                    _scaffoldKeyCategoryItemAdmin.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("Something went wrong with Cheese upload, Try VPN.",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);
                                                  }
                                                  else{
                                                    _scaffoldKeyCategoryItemAdmin.currentState.showSnackBar(
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
                                                    fontSize: 50,
                                                    color: Colors.blueGrey),)
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
