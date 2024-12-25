import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseMethods {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Add user details to Firestore
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  // Update user wallet in Firestore
  Future updateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Wallet": amount});
  }

  // Add food details to the Realtime Database
  // Future addFoodItem(Map<String, dynamic> foodData, String itemId) async {
  //   try {
  //     await _database.child("foodItems").child(itemId).set(foodData);
  //     return true;
  //   } catch (e) {
  //     print("Error adding food item: $e");
  //     return false;
  //   }
  // }
  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }
}
