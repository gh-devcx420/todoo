import 'package:flutter/material.dart';
import 'package:todoo_app/enums.dart';

Map<AppColours, Color> seedColourMap = {
  AppColours.purple: Colors.purple,
  AppColours.indigo: Colors.indigo,
  AppColours.blue: const Color.fromARGB(255, 0, 103, 164),
  AppColours.green: Colors.green,
  AppColours.yellow: const Color.fromARGB(255, 200, 160, 0),
  AppColours.orange: Colors.orange,
  AppColours.red: Colors.red,
  AppColours.cyan: const Color.fromARGB(255, 0, 188, 212),
};

EdgeInsets kScaffoldBodyPadding =
    const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
EdgeInsets kTodooCardPadding =
    const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
EdgeInsets kTodooTagPadding =
    const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
EdgeInsets kTodooButtonPadding = const EdgeInsets.all(6);
EdgeInsets kTodooButtonMargin = const EdgeInsets.all(2);
double kTodooAppRoundness = 16.0;
