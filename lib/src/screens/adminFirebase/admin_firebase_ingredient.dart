
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseIngredientBloc.dart';
import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';
// import 'package:linkupadminolddb/src/DataLayer/models/IngredientSubgroup.dart';


import 'package:linkupadminolddb/src/DataLayer/models/NewIngredient.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

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
  // File _image;
  PickedFile _image;

  final _formKey = GlobalKey<FormState>();
  var onlyDigitsAndPoints = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
  Radius zero = Radius.circular(6.0);
//  Radius.circular(0.0);

  int _currentCategory= 0;
  bool _loadingState = false;


  final picker = ImagePicker();


  TextEditingController ingredientEditingController = new TextEditingController();
  TextEditingController priceEditingController = new TextEditingController();
  // TextEditingController usernameEditingController =  new TextEditingController();



  Future getImage() async {

    var image = await picker.getImage(
      // await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );

    print('_image initially: $_image');
    print('image at getImage: $image');

    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);





    // blocAdminCategoryFBase.setImage(image);

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

                    //final OldCategoryItem currentOldCategory = snapshot.data;


                    if(currentIngredient.ingredientName==''){
                      ingredientEditingController.clear();
                    }

                    // if(currentIngredient.price==''){
                    //   priceEditingController.clear();
                    // }



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
                                              // child: Image.file(_image),
                                              child: Image.file(File(_image.path)),

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
                                            fontFamily: 'Itim-Regular',
                                          ),
                                        ),

                                        controller: ingredientEditingController,
                                        validator: (value) {

                                          return value.isEmpty? 'please enter the ingredient Name.' : null;

                                        },


                                        // onSaved: (val) =>
                                        onChanged: (val) =>
                                            blocAdminIngredientFBase.setIngredientName(val),
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
                                                controller: priceEditingController,
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


                                                  final blocAdminIngredientFBase =
                                                  BlocProvider.of<AdminFirebaseIngredientBloc>(context);
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

                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 10.0),
                                          child: RaisedButton(
                                            // color: Colors.yellowAccent,
                                              color: Color(0xffB8D03F),
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
                                                    fontSize: 20,
                                                    color: Color(0xffFF4686)),)
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
