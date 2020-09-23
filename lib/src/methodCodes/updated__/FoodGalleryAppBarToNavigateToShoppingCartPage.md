
## to navigate to shopping cart page from smaller mobile devices...


### for bigger devices...

```dart

                        Container(

                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),

//                                          width: displayWidth(context) / 6,
                          height: displayHeight(context) / 15,
//                                            color:Colors.red,
                          child:

//                                          Container(child: Image.asset('assets/Path2008.png')),
                          Container(
                            padding:EdgeInsets.fromLTRB(0,1,0,0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jediline',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 30,
                                      color: Color(0xff07D607),
                                      fontFamily: 'Itim-Regular'),
                                ),
                                Text(
                                  'Online Orders',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16.42,color: Color(0xff07D607)),
                                ),
                              ],
                            ),
                          ),


                        ),
```


## modified for smaller devices:

```dart



 Container(

                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),

//                                          width: displayWidth(context) / 6,
                          height: displayHeight(context) / 15,
//                                            color:Colors.red,
                          child:

//                                          Container(child: Image.asset('assets/Path2008.png')),
                          Container(
                            padding:EdgeInsets.fromLTRB(0,1,0,0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jediline',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20,
                                      color: Color(0xff07D607),
                                      fontFamily: 'Itim-Regular'),
                                ),
                                Text(
                                  'Online Orders',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10.42,color: Color(0xff07D607)),
                                ),
                              ],
                            ),
                          ),


                        ),


```


### sizedBox::
### width: 200 not necessesary at least for mobile devices;;;


```dart
  SizedBox(
                    height: kToolbarHeight + 6, // 6 for spacing padding at top for .
                    width: 200,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
//                                          color: Colors.yellow,
//                                          margin: EdgeInsets.symmetric(
//                                              horizontal:0,
//                                              vertical: 0),

//                                          width: displayWidth(context) / 13,
                          height: displayHeight(context) / 15,
//                                            color:Colors.blue,
                          child: Image.asset('assets/Path2008.png'),

                        ),


                        Container(

                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),

//                                          width: displayWidth(context) / 6,
                          height: displayHeight(context) / 15,
//                                            color:Colors.red,
                          child:

//                                          Container(child: Image.asset('assets/Path2008.png')),
                          Container(
                            padding:EdgeInsets.fromLTRB(0,1,0,0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jediline',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20,
                                      color: Color(0xff07D607),
                                      fontFamily: 'Itim-Regular'),
                                ),
                                Text(
                                  'Online Orders',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10.42,color: Color(0xff07D607)),
                                ),
                              ],
                            ),
                          ),


                        ),

                      ],
                    ),
                  ),
```

### input container's container width changed:

### from : displayWidth(context) /4.7 to .../5.7 on august 27....
## then  width: displayWidth(context) / 7.7,

## width: displayWidth(context) / 4.3, from.... /3.3....
```dart

 Container(
                          alignment: Alignment.center,
                          width: displayWidth(context) / 5.7,
//                                        color:Colors.purpleAccent,
                          // do it in both Container
                          child: TextField(
                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                              border: InputBorder.none,
//                                              hintText: 'Search about meal',
//                                              hintStyle: TextStyle(fontWeight: FontWeight.bold),


//                                        labelText: 'Search about meal.'
                            ),
                            onChanged: (text) {
//                                              logger.i('on onChanged of condition 4');

                              setState(() =>
                              _searchString = text);
                              print(
                                  "First text field from Condition 04: $text");
                            },
                            onTap: () {
                              print('condition 4');
//                                              logger.i('on Tap of condition 4');
                              setState(() {
                                _firstTimeCategoryString =
                                'PIZZA';
                              });
                            },

                            onEditingComplete: () {
//                                              logger.i('onEditingComplete  of condition 4');
                              print(
                                  'called onEditing complete');
                              setState(() =>
                              _searchString = "");
                            },

                            onSubmitted: (String value) async {
                              await showDialog<void>(
                                context: context,
                                builder: (
                                    BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Thanks!'),
                                    content: Text(
                                        'You typed "$value".'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),

                        )
```