import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooleanNotifier extends StateNotifier<bool> {
  BooleanNotifier() : super(false);

  void toggle() => state = !state;
  void setTrue() => state = true;
  void setFalse() => state = false;
}

// Define a StateNotifierProvider
final booleanNotifierProvider = StateNotifierProvider<BooleanNotifier, bool>((ref) => BooleanNotifier());