import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeSeedColourNotifier extends StateNotifier<Color> {
  AppThemeSeedColourNotifier() : super(Colors.green);

  void changeSeedColour(Color newSeedColour) {
    state = newSeedColour;
  }
}

final appThemeSeedColourProvider =
    StateNotifierProvider<AppThemeSeedColourNotifier, Color>((ref) {
  return AppThemeSeedColourNotifier();
});
