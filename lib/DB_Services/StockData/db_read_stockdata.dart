// import 'package:firebase_database/firebase_database.dart';

// class Db_ReadService_2000Stockdata {
//   FirebaseDatabase db = FirebaseDatabase.instance;

//   // FirebaseDatabase db = FirebaseDatabase.instanceFor(
//   //     app: Firebase.app(),
//   //     databaseURL: "https://xxxxxxxx.firebaseio.com/");

//   //Get ScreenerResult List
//   Future<List<dm_stock>?> get2000StockList() async {
//     //Persistance to keep the database from refreshing always
//     db.setPersistenceEnabled(true);
//     final ref = db.ref();
//     DataSnapshot snapshot =
//         await ref.child('xxxxxx').orderByChild("xxxxxx").get();

//     List<dm_stock> totalstocklist = [];
//     if (snapshot.exists) {
//       print('Total stocks found in StockEx app');
//       var datalist = snapshot.value as Map<dynamic, dynamic>;
//       datalist.forEach((key, value) {
//         dm_stock stock = dm_stock.fromJson2(value);
//         stock.stckname = key.toString();
//         stock.pcnt = CalculatePcnt(stock);
//         totalstocklist.add(stock);
//       });
//     } else {
//       print('No stocks found');
//     }
//     return totalstocklist;
//   }

//   // Realtime Listeners for Nifty 50
//   Stream<List<dm_stock>> getrealtime_2000Stocks_Live() {
//     return db
//         .ref()
//         .child("xxxxxx")
//         // .orderByChild("xxxxxx") // To preserve the server load
//         .onValue
//         .map((event) => event.snapshot.children.map((e) {
//               var value = e.value; // Extract value before fromJson2 is called
//               return dm_stock.fromJson2(value as Map<dynamic, dynamic>);
//             }).toList());
//   }
// }
