import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedServiceProvider =
    StateProvider.autoDispose<String?>((ref) => null);
final selectedSlotProvider = StateProvider.autoDispose<String?>((ref) => null);
final paymentMethodProvider =
    StateProvider.autoDispose<String>((ref) => "Cash on Delivery");
