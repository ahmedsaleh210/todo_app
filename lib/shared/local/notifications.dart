import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz; //for initialize tz

class NotificationServices{
  static final notificationServices = FlutterLocalNotificationsPlugin();
  static Future<void> init() async{
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings
    );

    await notificationServices.initialize(settings,onSelectNotification: onSelectedNotification);
  }

  static Future<NotificationDetails> _notificationDetails() async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
    );
    return const NotificationDetails(android: androidNotificationDetails);

  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body
})async{
  final details = await _notificationDetails();
  await notificationServices.show(
      id,
      title,
      body,
      details);
  }

  static Future<void> showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date
  })async{
    final details = await _notificationDetails();
    tz.TZDateTime setDate(year,month,day,hour,minutes){
      tz.TZDateTime scheduleDate =
      tz.TZDateTime(tz.local, year, month, day, hour, minutes);
      return scheduleDate;
    }
    await notificationServices.zonedSchedule(
        id,
        title,
        body,
        setDate(date.year,date.month,date.day,date.hour,date.minute),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );

  }

  static void onSelectedNotification(String? payload) {
  }

  static Future<void> cancelNotifications(int id) async {
    await notificationServices.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await notificationServices.cancelAll();
  }
}

