import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce1/services/authService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the provider for total price
final priceProvider = StateNotifierProvider<PriceNotifier, double>((ref) {
  return PriceNotifier();
});

// StateNotifier to manage the price calculation
class PriceNotifier extends StateNotifier<double> {
  PriceNotifier() : super(0.0);

  void updatePrice() async {
    try {
      final snapshots = await FirebaseFirestore.instance
          .collection(
              "users") // Corrected the collection name from "uses" to "users"
          .doc(uuid)
          .collection('cart')
          .get();

      double totalPrice = 0.0;

      for (var doc in snapshots.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final count = data['count'] ?? 0;
        final price = data['price'] ?? 0.0;

        totalPrice += count * price;
      }

      state = totalPrice;
    } catch (e) {}
  }

  void setPrice(double totalPrice) {
    state = totalPrice;
  }
}
