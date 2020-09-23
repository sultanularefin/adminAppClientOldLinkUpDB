
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseSauceBloc.dart';

import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';
import 'package:linkupadminolddb/src/DataLayer/models/SauceItem.dart';


import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:linkupadminolddb/src/utilities/screen_size_reducers.dart';







class AdminFirebaseSauces extends StatefulWidget {

  final Widget child;

  AdminFirebaseSauces({Key key, this.child}) : super(key: key);
  _AddDataState createState() => _AddDataState();

}


class _AddDataState extends State<AdminFirebaseSauces> {

  final GlobalKey<ScaffoldState> _scaffoldKeySauceItemAdmin = new GlobalKey<ScaffoldState>();


  File _image;

  final _formKey = GlobalKey<FormState>();
  var onlyDigitsAndPoints = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
  Radius zero = Radius.circular(2.0);


  int _currentCategory= 0;
  bool _loadingState = false;


  Future getImage() async {

    var image = await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );

    print('_image initially: $_image');
    print('image at getImage: $image');

    final blocAdminSauceFBase = BlocProvider.of<AdminFirebaseSauceBloc>(context);




    blocAdminSauceFBase.setImage(image);



//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    final FirebaseUser user = await _auth.currentUser();



    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = FirebaseAuth.instance.currentUser;




    blocAdminSauceFBase.setUser(user.email);

    setState(() {
      _image = image;
    });
  }



  @override
  Widget build(BuildContext context) {

    final blocAdminSauceFBase =
    /*final blocAdminFoodFBase = */ BlocProvider.of<AdminFirebaseSauceBloc>(context);


      print('at _loadingState == false in AdminFirebase Ingredient...');
      return SafeArea(
        child: Theme(
          data: ThemeData(primaryIconTheme: IconThemeData(

            color: Colors.blueGrey,
            // size: 40,

          ),
          ),// use this
          child: new Scaffold(
              key:_scaffoldKeySauceItemAdmin,
//          appBar: AppBar(title: Text('Admin Firebase Ingredient')),

              appBar: AppBar(
                title: Text('Admin Sauce Upload',

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
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//              ....
                child: StreamBuilder<SauceItem>(
                    stream: blocAdminSauceFBase.thisSauceItemStream, //null,
                    initialData: blocAdminSauceFBase.getCurrentSauceItem,
                    builder: (context, snapshot) {
                      final SauceItem currentIngredient = snapshot.data;

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

                                            }, child:

                                          new CircleAvatar(

                                            backgroundColor: Colors.blueGrey,
                                            radius: 130,


                                            child: new Container(

                                                height:100,
                                                width:180,

                                                child: Text('no Sauce image selected.',
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

                                            ,)
                                          /*new CircleAvatar(

                                              backgroundColor: Colors.lightBlueAccent,
                                              radius: 180.0,

                                              child: new Container(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: new Container(
                                                    child: Text('no Sauce image selected.',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 34,
                                                        fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                        color: Colors.redAccent,
                                                        fontFamily: 'Itim-Regular',

                                                      ),),

                                                  )

                                              )

                                          ),

                                            */
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
                                          InputDecoration(
//                                            icon: Icon(Icons.edit),
                                            labelText: 'sauce Item Name',
                                            labelStyle:TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                              color: Colors.redAccent,
                                              fontFamily: 'Itim-Regular',

                                            ),


                                          ),
                                          validator: (String value) {

                                            return value.isEmpty? 'Please enter the sauce Name.' : null;
//                                            if (value.isEmpty) {
//
//                                              return 'Please enter the sauce Name';
//                                            }
                                          },
                                          // onSaved: (val) =>
                                          onChanged: (val) =>
                                              blocAdminSauceFBase.setItemName(val),
                                        ),





                                        SizedBox(height: 50),


                                        Container(
                                          height:60,
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
                                                  textInputAction: TextInputAction.done,
//                                                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter price';
                                                    }
                                                  },
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(

                                                    border: OutlineInputBorder(borderRadius: BorderRadius.
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


                                                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseSauceBloc>(context);
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



                                                  blocAdminSauceFBase.setUser(user.email);


                                                  if (form.validate()) {
                                                    form.save();

                                                    _scaffoldKeySauceItemAdmin.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 5), content:Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("uploading sauce Item data....",style:
                                                            TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                          ],
                                                        ),
                                                      )),);

                                                    int loginRequiredStatus =  await blocAdminSauceFBase.saveSauces();


                                                    if (loginRequiredStatus == 0) {
                                                      _scaffoldKeySauceItemAdmin.currentState.showSnackBar(
                                                        new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                          child:
                                                          new Row(
                                                            children: <Widget>[
                                                              new CircularProgressIndicator(),
                                                              new Text("Something went wrong with sauce upload, Try VPN.",style:
                                                              TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                            ],
                                                          ),
                                                        )),);
                                                    }
                                                    else{
                                                      _scaffoldKeySauceItemAdmin.currentState.showSnackBar(
                                                        new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                          child:
                                                          new Row(
                                                            children: <Widget>[
                                                              new CircularProgressIndicator(),
                                                              new Text("success! sauce added check firestore and storage",style:
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
