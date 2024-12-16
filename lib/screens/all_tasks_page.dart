import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:todoo_app/constants.dart';
import 'package:todoo_app/screens/settings_screen.dart';
import 'package:todoo_app/widgets/tasks_button.dart';
import 'package:todoo_app/widgets/tasks_card.dart';

import '../providers/tasks_provider.dart';

class AllTasksScreen extends ConsumerWidget {
  const AllTasksScreen({super.key});

  void _navigateToSettingsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Image.asset('assets/illustrations/Add.png'),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );

    final taskListWatcher = ref.watch(allTasksProvider);
    if (taskListWatcher.isNotEmpty) {
      content = Padding(
        padding: kScaffoldBodyPadding,
        child: ListView(
          children: [
            ...taskListWatcher.map(
              (todooTask) => TodooTaskCard(currentTask: todooTask),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoo'),
        centerTitle: true,
        actions: [
          TodooButton(
            onButtonTap: () {
              _navigateToSettingsScreen(context);
            },
            icon: MaterialSymbols.settings,
            iconSize: 18,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(6),
          )
        ],
      ),
      body: content,
    );
  }
}
