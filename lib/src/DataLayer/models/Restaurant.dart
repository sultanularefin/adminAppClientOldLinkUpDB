


//import 'package:linkupclient/src/DataLayer/models/SelectedFood.dart';
//import 'packages:foodgallery/src/DataLayer/models/NewIngredient.dart';
//final String storageBucketURLPredicate_Same =
//    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';

class Restaurant {

  Map     <String,dynamic> address;
  Map     <String,dynamic> attribute;

  List    <dynamic> cousine;
  bool    kidFriendly; // kid_friendly
  bool    reservation;
  bool    romantic;
  List    <String> offday;
  String  open;
  String  avatar;
  String  contact;
  double  deliveryCharge;
  double  discount;// from string;// need to convert string to double.
  String  name;
  double  rating;
  double  totalRating;

  // int     selectedTabIndex;

  // {0:menu}, {1:offer}, {2:cart};
  // SELECTEDTABINDEX ONLY FOR THE CLIENT APPLICATION.

//  address map, attribute map, cousine array, kid_friendly boolean, offday array,
//      open String, reservation boolean, romantic: boolean, avatar: String, contact: string,
//  delivery_charge: double, discount: dousble[string], name: String, rating:double, total_rati
//  List<SelectedFood> selectedFoodInOrder;
//  int selectedFoodListLength;
//
//  int orderTypeIndex;
//  int paymentTypeIndex;
//  CustomerInformation ordersCustomer;
//  double totalPrice;
  //int page; // page =(0,1) = (0: from FoodGallery Page, 1: from Shopping Cart Page);

  // SINCE WE DON'T NEED TO
  // CALCULATE THIS PRICE IN SHOPPING CART PAGE BUT DO IT IN FOOD GALLERY PAGE,
  //  AND PASS LATER PAGES.

//  String ingredients;
//  itemId = await generateItemId(6);

  Restaurant(
      {
        this.address,
        this.attribute,
        this.cousine,
        this.kidFriendly,
        this.reservation,
        this.romantic,
        this.offday,
        this.open,
        this.avatar,
        this.contact,
        this.deliveryCharge,
        this.discount,
        this.name,
        this.rating,
        this.totalRating,
//        this.selectedTabIndex:0,
        // this.foodItemOrderID,
      }
      );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)

//  OrderList.fromMap(Map<String, dynamic> data,String docID)
//      :imageURL= data['image'],
//        ingredientName= data['name'],
//        price = data['price'].toDouble(),
//        documentId = docID,
//        ingredientAmountByUser = 1;

}
