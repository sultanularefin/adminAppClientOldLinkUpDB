
// package/ external dependency files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/HistoryDetailsBloc.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
//import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/BLoC/history_bloc.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';

// BLOC'S IMPORT BEGIN HERE:
//import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
//import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


// MODEL'S IMPORT BEGINS HERE.
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';



import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodgallery/src/screens/history/HistoryDetailsPage.dart';
import 'package:foodgallery/src/screens/shoppingCart/ShoppingCart.dart';

import 'package:logger/logger.dart';

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

// Screen files.


// models, dummy data file:

import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';


class HistoryPage extends StatefulWidget {

  final Widget child;


  HistoryPage({Key key, this.child}) : super(key: key);
  _HistoryPageState createState() => _HistoryPageState();

}


class _HistoryPageState extends State<HistoryPage> {

  final GlobalKey<ScaffoldState> _scaffoldKeyHistoryPage = new GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Menu button pressed'));

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  _HistoryPageState(/*{firestore} */);


  String _currentPageHeader = 'HISTORY';

  double tryCast<num>(dynamic x, {num fallback }) {
    bool status = x is num;

    if(status) {
      return x.toDouble() ;
    }
    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}

    else return 0.0;
  }

  var logger = Logger(
    printer: PrettyPrinter(),
  );


  @override
  Widget build(BuildContext context) {

    final blocG = BlocProvider.of<HistoryBloc>(context);

// FOODLIST LOADED FROM FIRESTORE NOT FROM STATE HERE
    return GestureDetector(
      onTap: () {
        print('...on tap....');
        // return Navigator.pop(context);

        // not required to go back if touched all the places in the screen.

        // Navigator.pop(context);
      },
      child:
      Scaffold(
        backgroundColor: Colors.white.withOpacity(0.05),
        // this is the main reason of transparency at next screen.
        // I am ignoring rest implementation but what i have achieved is you can see.
        key: _scaffoldKeyHistoryPage,
        body:
        WillPopScope(
          onWillPop: () {

            // return Navigator.pop(context);
            Navigator.pop(context);
            return new Future(() => false);
          },

            child: Container(
//            color:Colors.lightGreenAccent,
              color:Colors.white,
              height: displayHeight(context) -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -kToolbarHeight,
              margin: EdgeInsets.fromLTRB(
                  0, displayHeight(context)/16, 10, 20),
//                            kToolbarHeight
              child:
              Container(
//              color:Colors.red,
                color:Colors.white,
                width: displayWidth(context)/1.03,
//                        height: displayHeight(context) + kToolbarHeight + 10,
                height: displayHeight(context)/2.1,
                /*
*/
                child: allHistoryList(_currentPageHeader, context),

              ),



            ),
          ),


      ),

    );
  }




  String titleCase(var text) {
    // print("text: $text");
    if (text is num) {
      return text.toString();
    } else if (text == null) {
      return '';
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      return text
          .split(' ')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');


    }
  }


  String listTitleCase(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);
    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }


    // print("text: $text");
    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }


    else {
      return stringList
          .map((word) => word.toString().split(' ')
          .map((word2) => titleCase(word2)).join(' '))
          .join(', ');

    }

  }


  Widget allHistoryList(String pageHeaderString,BuildContext context)  {

    final blocH = BlocProvider.of<HistoryBloc>(context);

    return Container(

      child:
      StreamBuilder<List<OneOrderFirebase>>(
        stream: blocH.getFirebaseOrderListStream,
        initialData: blocH.getAllFirebaseOrderList,

        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(

                margin: EdgeInsets.fromLTRB(
                    0, displayHeight(context) / 2, 0, 0),

                child: Center(
                  child: Column(
                    children: <Widget>[

                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.lightGreenAccent)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                              backgroundColor: Colors.yellow,)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.redAccent)
                        ),
                      ),
                    ],
                  ),
                ),

              );
              break;
            case ConnectionState.active:
//          print('snapshot.hasData FG2 : ${snapshot.hasData}');

            default:
              if (!snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.fromLTRB(
                      0, displayHeight(context) / 2, 0, 0),
                  child: Center(
                    child: Column(
                      children: <Widget>[

                        Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text('....')
                          ),
                        ),

                        Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: new CircularProgressIndicator(
                                  backgroundColor: Colors.redAccent)
                          ),
                        ),
                      ],
                    ),
                  ),

                );
              }

              else {

                print('categoryString  ##################################: $pageHeaderString');

                final List<OneOrderFirebase> allFoods = snapshot.data;


                final int categoryItemsCount = allFoods.length;
                print('categoryItemsCount: $categoryItemsCount');

                return
                  Column(
                    children: <Widget>[

                      Container(

                        height: displayHeight(context) / 20,
                        color: Color(0xffffffff),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Spacer(),
                              CustomPaint(size: Size(0, 19),
                                painter: LongHeaderPainterBefore(context),
                              ),
                              Text('$_currentPageHeader'.toUpperCase(),
                                style:
                                TextStyle(

                                  // fontFamily: 'Itim-Regular',
                                  // fontFamily: 'Poppins-ExtraBold',
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
                                  color: Color(0xff000000),
                                ),
                              ),
                              CustomPaint(size: Size(0, 19),
                                painter: LongHeaderPainterAfter(context),
                              ),
                              Spacer(),
                            ]
                        ),


                      ),
                      Container(
//                        height: displayHeight(context)/2.1-displayHeight(context) / 20,
//                      color:Colors.purple,

                        height: displayHeight(context) -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom  -displayHeight(context) / 6
                        /* /20 being title text height..*/,

                        child: fireBaseOrderList(allFoods, context),
                      ),


                    ],

                  );
              }


          }

        },
      ),
    );
  }

//  child: fireBaseOrderListNoSearch(context),
//
//  Widget fireBaseOrderListNoSearch(BuildContext context)  {


  /*
  *
  * Container(
                        color:Colors.red,
                        //sss
                        width: 70,
                        height:70,
                        child: Image.asset(
                          oneOrderForReceipt.paidType.toLowerCase() == 'card' ?
                          'assets/unpaid_cash_card/card.png'
                              :oneOrderForReceipt.paidType.toLowerCase() == 'cash'?
                          'assets/unpaid_cash_card/cash.png':'assets/unpaid_cash_card/unpaid.png',

//                color: Colors.black,
                          width: 50,
                          height:50,

                        ),
                      ),
  * */
  Widget fireBaseOrderList(
      List<OneOrderFirebase> filteredItemsByCategory,
      BuildContext context)  {

    return Container(
//      height:displayHeight(context)/2.1-displayHeight(context) / 20,

      height: displayHeight(context) -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom - displayHeight(context) / 4
      /* /20 being title text height..*/
      ,
//      color:Colors.deepOrange,
//      height: displayHeight(context) -
//          MediaQuery
//              .of(context)
//              .padding
//              .top -MediaQuery
//          .of(context)
//          .padding
//          .bottom,

      child: GridView.builder(
        itemCount: filteredItemsByCategory.length,
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(

          //Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 0, // H  direction
//          crossAxisSpacing: 5, // horizontal padding error check image snpashot for details in august 10.
          childAspectRatio: 140 / 180,


        ),
        shrinkWrap: false,

        itemBuilder: (_, int index) {

          final String orderType2 = filteredItemsByCategory[index].orderType;
          final String paidStatus2 = filteredItemsByCategory[index].paidStatus;

          final String formattedOrderPlacementDate2 = filteredItemsByCategory[index]
              .formattedOrderPlacementDate;

          final String formattedOrderPlacementDatesTimeOnly2 = filteredItemsByCategory[index].
          formattedOrderPlacementDatesTimeOnly;
          final String orderBy2 = filteredItemsByCategory[index].
          orderBy;



          String itemImage2 = (orderBy2.toLowerCase() == 'delivery') ?
          'assets/orderBYicons/delivery.png' :
          (orderBy2.toLowerCase() == 'phone') ?
          'assets/phone.png': (orderBy2.toLowerCase() == 'takeaway')
              ? 'assets/orderBYicons/takeaway.png'
              : 'assets/orderBYicons/diningroom.png';

          String documentID = filteredItemsByCategory[index].documentId;

          CustomerInformation       oneCustomer2 = filteredItemsByCategory[index].oneCustomer;
          List<OrderedItem> orderedItems2 = filteredItemsByCategory[index].orderedItems;


          String paidType2= filteredItemsByCategory[index].paidType;
          double                    totalPrice2 = filteredItemsByCategory[index].totalPrice;

          String                    contact2 = filteredItemsByCategory[index].contact;

          String driverName2 = filteredItemsByCategory[index].driverName;


          DateTime                  endDate2 = filteredItemsByCategory[index].endDate;
          DateTime                  startDate2 = filteredItemsByCategory[index].startDate;


//          String         formattedOrderPlacementDate2 = filteredItemsByCategory[index].formattedOrderPlacementDate;
//          String           formattedOrderPlacementDatesTimeOnly2 = filteredItemsByCategory[index].formattedOrderPlacementDatesTimeOnly;


          String                    orderStatus2 = filteredItemsByCategory[index].orderStatus;
          String                    tableNo2 = filteredItemsByCategory[index].tableNo;


          String                    documentId2 = filteredItemsByCategory[index].documentId;
          double                    deliveryCost2 = filteredItemsByCategory[index].deliveryCost;
          double                    tax2 = filteredItemsByCategory[index].tax;

          // double                    priceWithDelivery2 = filteredItemsByCategory[index].priceWithDelivery;
          // int                       orderProductionTime2 = filteredItemsByCategory[index].orderProductionTime;

          double                    priceWithDelivery2 = filteredItemsByCategory[index].priceWithDelivery;
          int                       orderProductionTimeFromNow2 = filteredItemsByCategory[index].orderProductionTimeFromNow;
          String                    timeOfDay2    = filteredItemsByCategory[index].timeOfDay;


          OneOrderFirebase oneOrderFirebaseTemp = new  OneOrderFirebase(

            formattedOrderPlacementDatesTimeOnly: formattedOrderPlacementDatesTimeOnly2,
            formattedOrderPlacementDate: formattedOrderPlacementDate2,
            orderType: orderType2,
            paidStatus: paidStatus2,
            oneCustomer:oneCustomer2,
            orderedItems: orderedItems2,
            orderBy:orderBy2,
            paidType: paidType2,
            totalPrice: totalPrice2,
            contact: contact2,
            driverName: driverName2,

            endDate:endDate2,
            startDate:startDate2,
            orderStatus:orderStatus2,
            tableNo: tableNo2,
            documentId:documentId2,
            deliveryCost:deliveryCost2,
            tax:tax2,
            priceWithDelivery:priceWithDelivery2,
            orderProductionTimeFromNow:orderProductionTimeFromNow2,
            timeOfDay: timeOfDay2,

//              CustomerInformation       oneCustomer;
//          List<OrderedItem>         orderedItems;
//          String                    orderBy;
//              String                    paidStatus;
//              String                    paidType;

//              double                    totalPrice;

//              String                    contact;
//          String                    driverName;

//          DateTime                  endDate;
//          DateTime                  startDate;

//          String                    formattedOrderPlacementDate;
//          String                    formattedOrderPlacementDatesTimeOnly;

//          String                    orderStatus;
//              String                    tableNo;
//              String                    orderType;

//              String                    documentId;
//              double                    deliveryCost;
//          double                    tax; // 14% upon total Cost.

//          double                    priceWithDelivery;
//          int                       orderProductionTime;


          );



          return
            Container(

                color: Color(0xffFFFFFF),
//            color:Colors.lightGreenAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: 4.0, vertical: 16.0),
                child: InkWell(
                  child: Column(

                    children: <Widget>[




//                      hero animation.. image container begins here.

                      new Container(
                        width: displayWidth(context) /  6,
                        height: displayWidth(context) / 6,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFCF5E4),
                          border: new Border.all(
                              color: Colors.yellow,
                              width: 1.0,
                              style: BorderStyle.solid
                          ),
//                            shape: BoxShape.circle,

                        ),

                        child:
                        ClipOval(
                          child: Hero(
                            tag: startDate2.toString()+'__$totalPrice2',

                            child:
                            Container(
//                            color:Colors.pinkAccent,

                              padding: EdgeInsets.fromLTRB(20,20,20,20),//                            ssssssHHHHH

                              child: Image.asset(
                                itemImage2,
                                fit: BoxFit.contain,
                              ),

                            ),
                            placeholderBuilder: (context,
                                heroSize, child) {
                              return Opacity(
                                opacity: 0.5, child: Container(
                                width: displayWidth(context) /  6,
                                height: displayWidth(context) / 6,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffEAB45E),
                                        blurRadius: 25.0,
                                        spreadRadius: 0.10,
                                        offset: Offset(0, 10)
                                    )
                                  ],
                                ),
                                child:
                                Container(
                                  padding: EdgeInsets.fromLTRB(20,20,20,20),//  
                                  child: ClipOval(
                                    child: Image.asset(
                                      itemImage2,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              );
                            },
                          ),
                        ),

                      ),




//                      hero animation.. image container ends here.












                      Container(
                        padding: const EdgeInsets.fromLTRB(
                            0, 5, 0, 6),
                        child: Text(
                          '${orderBy2.toUpperCase()}',
                          style: TextStyle(
                              fontWeight: FontWeight
                                  .w600,
//                                          color: Colors.blue,
                              color: Color.fromRGBO(
                                  112, 112, 112, 1),
                              fontSize: 15),
                        ),
                      ),

                      Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                        '${paidStatus2.toUpperCase()}',

                        style: TextStyle(
                            fontWeight: FontWeight
                                .w600,
//                                          color: Colors.blue,
                            color: Color.fromRGBO(
                                112, 112, 112, 1),
                            fontSize: 15),
                      ),

                      Container(

                          child: Text(

                            formattedOrderPlacementDate2 + ' ' + formattedOrderPlacementDatesTimeOnly2,

//                                    foodItemIngredients.substring(0,10)+'..',
                            style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.normal,

                              letterSpacing: 0.5,
                              fontSize: 14,
                            ),
                          )
                      ),
//
//
                    ],
                  ),
                  onTap: () {
                    _navigateAndDisplaySelection(
                        context, oneOrderFirebaseTemp);
                  },


                )
            );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
        },

      ),
    );
  }



  _navigateAndDisplaySelection(BuildContext context,OneOrderFirebase oneFirebaseOrderItem) async {


    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    return Navigator.of(context).push(


      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(
            milliseconds: 900),
        pageBuilder: (_, __, ___) =>
            BlocProvider<HistoryDetailsBloc>(
              bloc: HistoryDetailsBloc(
                oneFirebaseOrderItem,
              ),
              child: HistoryDetailsPage()

              ,),

      ),
    );

  }

// HELPER METHOD tryCast Number (1)
  int test1(SelectedFood x) {

    return x.quantity ;
  }

}










class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(50, 20);
    final p2 = Offset(5, 20);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongHeaderPainterAfter extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfter(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}



class LongHeaderPainterBefore extends CustomPainter {


  final BuildContext context;
  LongHeaderPainterBefore(this.context);


  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(-displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(-10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}