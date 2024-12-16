import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarNotifier extends StateNotifier<int> {
  BottomNavigationBarNotifier() : super(1);

  onNavBarItemTap(int nevValueOnTap) {
    state = nevValueOnTap;
  }
}

final bottomNavigationBarProvider =
    StateNotifierProvider<BottomNavigationBarNotifier, int>(
  (ref) {
    return BottomNavigationBarNotifier();
  },
);
