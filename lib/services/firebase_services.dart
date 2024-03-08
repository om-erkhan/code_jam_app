import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getRestaurants() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('restaurants').get();

      List<DocumentSnapshot<Map<String, dynamic>>> restaurants =
          querySnapshot.docs;
      restaurants.forEach((restaurant) {
        print('Restaurant ID: ${restaurant.id}');
        print('Restaurant Name: ${restaurant.data()!['name']}');
        // Add more fields as needed
      });

      return restaurants;
    } catch (e) {
      print('Error fetching restaurants: $e');
      return [];
    }
  }
}
