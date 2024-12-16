import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoo_app/providers/theme_colour_provider.dart';
import 'package:todoo_app/screens/home_tabs.dart';
import 'package:todoo_app/theme.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: TodooApp(),
    ),
  );
}

class TodooApp extends ConsumerStatefulWidget {
  const TodooApp({super.key});

  @override
  ConsumerState<TodooApp> createState() => _TodooAppState();
}

class _TodooAppState extends ConsumerState<TodooApp> {
  final TextStyle baseTextStyle = const TextStyle(
    fontFamily: 'JosefinSans',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  ColorScheme generateColourScheme(Color colour, Brightness brightness) =>
      ColorScheme.fromSeed(seedColor: colour, brightness: brightness);

  void initializeThemes(Color seedColour) {
    final lightColourScheme =
        generateColourScheme(seedColour, Brightness.light);
    final darkColourScheme = generateColourScheme(seedColour, Brightness.dark);
    lightTheme = AppTheme.lightTheme(baseTextStyle, lightColourScheme);
    darkTheme = AppTheme.darkTheme(baseTextStyle, darkColourScheme);
  }

  @override
  Widget build(BuildContext context) {
    final appSeedColourWatcher = ref.watch(appThemeSeedColourProvider);
    initializeThemes(appSeedColourWatcher);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const TodooHome(),
    );
  }
}
