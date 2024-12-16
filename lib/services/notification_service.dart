import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:todoo_app/models/tasks_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialize the time zones

    // Set the time zone to Asia/Kolkata
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    // Initialization settings for both Android and iOS
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the notifications plugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print('Notification plugin initialized successfully.');
  }

  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    print('Notification permission granted: $status');
    return status == PermissionStatus.granted;
  }

  static void testNotification() async {
    flutterLocalNotificationsPlugin.show(
      1,
      'Dummy',
      "dummy body",
      NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminder_channel',
          'Task Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> scheduleTaskNotification(
      BuildContext context, TodooTask task) async {
    // Check if task has a deadline
    if (task.deadlineDate == null || task.deadlineTime == null) {
      print(
          'Task deadline or time is null. Notification will not be scheduled.');
      return;
    }

    // Combine date and time
    final notificationTime = DateTime(
      task.deadlineDate.year,
      task.deadlineDate.month,
      task.deadlineDate.day,
      task.deadlineTime!.hour,
      task.deadlineTime!.minute,
    );

    // Print local and UTC times for debugging
    print('Local timezone: ${tz.local}');
    print(
        'Notification Time (Local): ${tz.TZDateTime.from(notificationTime, tz.local)}');
    print(
        'Notification Time (UTC): ${tz.TZDateTime.from(notificationTime, tz.local).toUtc()}');

    // Prevent scheduling for past times
    if (notificationTime.isBefore(DateTime.now())) {
      print(
          'Notification time is in the past. Notification will not be scheduled.');
      return;
    }

    try {
      // Schedule the notification in the local time zone
      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id.hashCode,
        'Task Reminder',
        task.title,
        tz.TZDateTime.from(notificationTime, tz.local),
        payload: 'Test Payload',
        // Ensure timezone is explicitly set
        NotificationDetails(
          android: AndroidNotificationDetails(
            'task_reminder_channel',
            'Task Reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print(
          'Notification scheduled successfully for ${tz.TZDateTime.from(notificationTime, tz.local)}');
    } catch (e) {
      print('Error scheduling notification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not set reminder'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  static void scheduleTaskNotification1() async {
    DateTime notificationTime = DateTime.now().add(Duration(seconds: 8));
    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Test',
      'Test body',
      payload: 'Test',
      tz.TZDateTime.from(notificationTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminder_channel',
          'Task Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
    print('Local timezone: ${tz.local}');
    print(
        'Notification Time (Local): ${tz.TZDateTime.from(notificationTime, tz.local)}');
    print(
        'Notification Time (UTC): ${tz.TZDateTime.from(notificationTime, tz.local).toUtc()}');
  }

  static Future<void> cancelTaskNotification(TodooTask task) async {
    await flutterLocalNotificationsPlugin.cancel(task.id.hashCode);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
