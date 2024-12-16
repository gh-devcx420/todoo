import 'package:intl/intl.dart';
import 'package:todoo_app/enums.dart';

class Utils {
  static String formatDate(DateTime pickedDate) {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(pickedDate);
  }

  static String formatTime(DateTime? pickedTime) {
    final formatter = DateFormat('hh:mm a');
    if (pickedTime != null) {
      return formatter.format(pickedTime);
    } else {
      return 'No Time Picked';
    }
  }

  static String getPriorityLabel(Priority priority) {
    if (priority == Priority.none) {
      return 'No Priority';
    }
    return '${priority.name.substring(0, 1).toUpperCase()}${priority.name.substring(1)} Priority';
  }

  static String getCategoryLabel(Category category) {
    if (category == Category.none) {
      return 'No Category';
    }
    return category.name.substring(0, 1).toUpperCase() +
        category.name.substring(1);
  }

  static String getColourLabel(AppColours colour) {
    return colour.name.substring(0, 1).toUpperCase() + colour.name.substring(1);
  }
}
