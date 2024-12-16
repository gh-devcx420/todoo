import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/icon_park_outline.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:todoo_app/enums.dart';
import 'package:uuid/uuid.dart';

Map<Category, Map<String, Color>> categoryIconMap = {
  Category.none: {Ic.outline_category: Colors.grey},
  Category.personal: {MaterialSymbols.person: Colors.pink.withOpacity(0.8)},
  Category.work: {MaterialSymbols.work: Colors.blue.withOpacity(0.8)},
  Category.shopping: {
    MaterialSymbols.shopping_cart_rounded: Colors.teal.withOpacity(0.8)
  },
  Category.focus: {Ri.focus_2_fill: Colors.purple.withOpacity(0.8)},
  Category.social: {Ion.md_people: Colors.lightGreen.withOpacity(0.8)},
  Category.recreation: {
    Ic.twotone_nature_people: Colors.deepPurple.withOpacity(0.8)
  }
};

Map<Priority, Map<String, Color>> priorityIconMap = {
  Priority.none: {Ic.outline_arrow_circle_up: Colors.grey},
  Priority.high: {Pepicons.exclamation_filled: Colors.red},
  Priority.medium: {IconParkOutline.menu_fold_one: Colors.orange},
  Priority.low: {Ic.round_low_priority: Colors.lightGreen},
};

class TodooTask {
  TodooTask({
    required this.title,
    this.description,
    required this.deadlineDate,
    this.deadlineTime,
    this.category,
    this.priority,
    this.location,
    this.isReminderActive,
    this.isCompleted,
  }) : id = const Uuid().v4();

  TodooTask.withID({
    required this.id,
    required this.title,
    this.description,
    required this.deadlineDate,
    this.deadlineTime,
    this.category,
    this.priority,
    this.location,
    this.isReminderActive,
    this.isCompleted,
  });

  String id;
  String title;
  String? description;
  DateTime deadlineDate;
  DateTime? deadlineTime;
  Priority? priority;
  Category? category;
  String? location;
  bool? isReminderActive;
  bool? isCompleted;
}
