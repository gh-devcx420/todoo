import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoo_app/enums.dart';
import 'package:todoo_app/models/tasks_model.dart';

class AllTasksNotifier extends StateNotifier<List<TodooTask>> {
  AllTasksNotifier()
      : super([
          TodooTask(
            title:
                'Title testing in State is also very long just to test it during development',
            description:
                'This is a super long description, but also very short just to test it during development',
            deadlineDate: DateTime.now(),
            deadlineTime: DateTime.now(),
            location: 'ff',
            category: Category.personal,
            isCompleted: false,
            isReminderActive: true,
            priority: Priority.high,
          )
        ]);

  void addTask(TodooTask newTask) {
    state = [
      ...state,
      TodooTask(
        title: newTask.title,
        description: newTask.description,
        deadlineDate: newTask.deadlineDate,
        deadlineTime: newTask.deadlineTime,
        category: newTask.category,
        priority: newTask.priority,
        location: newTask.location,
        isReminderActive: newTask.isReminderActive,
      ),
    ];
  }

  void editTask(TodooTask editedTask) {
    final index = state.indexWhere((task) => task.id == editedTask.id);

    if (index != -1) {
      state = state.where((task) => task.id != editedTask.id).toList()
        ..insert(index, editedTask);
    }
  }

  void deleteTask(TodooTask taskToDelete) {
    final index = state.indexWhere((task) => task.id == taskToDelete.id);

    if (index != -1) {
      state = state.where((task) => task.id != taskToDelete.id).toList();
    }
  }
}

final allTasksProvider =
    StateNotifierProvider<AllTasksNotifier, List<TodooTask>>((ref) {
  return AllTasksNotifier();
});

class CurrentEditingTaskNotifier extends StateNotifier<Map<bool, String>> {
  CurrentEditingTaskNotifier() : super({false: 'Not Editing'});

  void isEditingCurrently(bool isEditing, String iD) {
    state = {isEditing: iD};
  }
}

final currentEditingTaskProvider =
    StateNotifierProvider<CurrentEditingTaskNotifier, Map<bool, String>>((ref) {
  return CurrentEditingTaskNotifier();
});
