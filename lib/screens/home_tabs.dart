import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa_solid.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:todoo_app/providers/bottom_nav_bar_provider.dart';
import 'package:todoo_app/providers/tasks_provider.dart';
import 'package:todoo_app/screens/add_tasks_page.dart';
import 'package:todoo_app/screens/all_tasks_page.dart';
import 'package:todoo_app/screens/completed_tasks_page.dart';

class TodooHome extends ConsumerWidget {
  const TodooHome({super.key});

  Widget _decidePage(stateWatcher) {
    switch (stateWatcher) {
      case 0:
        return const CompletedTasksScreen();
      case 1:
        return const AllTasksScreen();
      case 2:
        return const AddTasksScreen();
      default:
        return const AllTasksScreen();
    }
  }

  SalomonBottomBarItem buildNavBarItem(
    int bottomNavBarIndexStateWatcher,
    BuildContext context, {
    required String icon,
    required String title,
    required int position,
  }) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return SalomonBottomBarItem(
      icon: Iconify(
        icon,
        size: 20,
        color: bottomNavBarIndexStateWatcher == position
            ? Theme.of(context).colorScheme.primary
            : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: bottomNavBarIndexStateWatcher == position
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
      ),
      selectedColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavBarIndexStateWatcher =
        ref.watch(bottomNavigationBarProvider);
    final bottomNavBarIndexStateReader =
        ref.read(bottomNavigationBarProvider.notifier);
    final isEditing = ref.read(currentEditingTaskProvider.notifier);
    return Scaffold(
      body: _decidePage(bottomNavBarIndexStateWatcher),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: bottomNavBarIndexStateWatcher,
        onTap: (newValueOnTap) {
          isEditing.isEditingCurrently(false, 'Adding Task');
          bottomNavBarIndexStateReader.onNavBarItemTap(newValueOnTap);
        },
        duration: const Duration(seconds: 1),
        selectedColorOpacity: 0.15,
        items: [
          buildNavBarItem(
            bottomNavBarIndexStateWatcher,
            context,
            icon: Ic.baseline_task_alt,
            title: 'Completed Tasks',
            position: 0,
          ),
          buildNavBarItem(
            bottomNavBarIndexStateWatcher,
            context,
            icon: FaSolid.tasks,
            title: 'All Tasks',
            position: 1,
          ),
          buildNavBarItem(
            bottomNavBarIndexStateWatcher,
            context,
            icon: Ic.round_add_task,
            title: 'Create Task',
            position: 2,
          ),
        ],
      ),
    );
  }
}
