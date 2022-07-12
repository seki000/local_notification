import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../payload_screen.dart';

class FlutterLocalNotificationRepository {

  final FlutterLocalNotificationsPlugin flnp =
      FlutterLocalNotificationsPlugin();

  Future<void> initTimeAndNotification(context) async {
    tz.initializeTimeZones(); //タイムゾーン初期化
    final timezone = await FlutterNativeTimezone
        .getLocalTimezone(); //端末のタイムゾーンを取得
    tz.setLocalLocation(tz.getLocation(timezone));

   // ペイロードの処理① アプリが落ちているときに通知タップして特別なページに飛ばす処理 ペイロードいらないなら消してよい
    final NotificationAppLaunchDetails?  _launchDetails =
    await flnp.getNotificationAppLaunchDetails();
    if (_launchDetails!=null){
      if (_launchDetails.didNotificationLaunchApp){ //didNotificationLaunchAppがtrueならば通知タップによって始まっているので、所望の動作を行う
        if (_launchDetails.payload != ""){
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => PayloadScreen()
            ),
          );
        } else {
        }
  }
  }
   // ペイロードの処理①


    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    const NotificationDetails(iOS: iOSPlatformChannelSpecifics);
    flnp.initialize(
      InitializationSettings(
        iOS: IOSInitializationSettings( //iosで通知を許可するかの処理、falseだと最初は許可されてなくて.requestPermissionsで許可を得る感じになるはず
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification:  (int id, String? title, String? body, String? payload){  //TODO 古いIOSで必要な設定らしい？
            showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text("title"),
                content: Text("body"),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Ok'),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayloadScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
          //IOSでアプリがバックグラウンドや終了時に通知バナーがタップされたときに呼ばれる
        ),
        android: AndroidInitializationSettings(
            '@drawable/ic_stat_name' //通知のアイコン設定,別のプロジェクトに移植してアイコンがおかしくなるのでandroid - app - src - resにあるrawフォルダをコピーする
        ),
      ),

      //ペイロードの処理② アプリが落ちていないときに通知タップして特別なページに飛ばす処理 ペイロードいらないなら消してよい
      onSelectNotification: (String? payload) {
        if (payload == "" ) { //setNow = payload null
          debugPrint('notification payload: $payload');
        }else if (payload != ""){
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => PayloadScreen()
            ),
          );
        }
      }
      //ペイロードの処理②
      );

  }

  Future<void> requestPermissionsOnIos(
      ) async {
    await flnp
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> setNowNotification(
      int quicklyNotificationId) async {
    await flnp.show(
      quicklyNotificationId, //IDは被ると上書きされるので、他と違う物を,
      'title:すぐに通知',
      '本文:すぐに通知',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          // largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
          color: Colors.blue,
          //アイコンの色設定
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: IOSNotificationDetails(),
      ),
      payload: '',
    );
  }

  Future<void> repeatOneMinutesNotification(
      int repeatOneMinutesNotificationId) async {
    await flnp.periodicallyShow(
      repeatOneMinutesNotificationId,
      'Title:1分ごとにリピート通知',
      '本文：リピート通知',
      RepeatInterval.everyMinute,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'repeat notification channel id',
          'repeat notification channel name',
          channelDescription: 'repeat notificationdescription',
          color: Colors.blue, //アイコンの色設定
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: IOSNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
    );
    Fluttertoast.showToast(
      msg: "1分ごとにリピート通知します。",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,);
  }

  Future<void> threeSecondsNotification(
      int threeSecondsNotificationId, BuildContext context) async {
      return
        await flnp.zonedSchedule(
        threeSecondsNotificationId, //IDは被ると上書きされるので、他と違う物を
        'Title:３秒後に通知',
        '本文：３秒後に通知',
        tz.TZDateTime.now(tz.UTC).add(Duration(seconds: 3)),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'set three minutes',
            'set three minutes',
            color: Colors.red,
            importance: Importance.max,
            priority: Priority.max,
            largeIcon:
            DrawableResourceAndroidBitmap('ic_stat_timer_3'), //drawableの画像指定
          ),
          iOS: IOSNotificationDetails(),
        ),
        payload: 'タップしたときに指定したページに移動します', //ペイロード必要な時は何か入れる、不要なら空にするか設定しない
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );

  }

   Future<void> cancelAllNotification() async {
    await flnp.cancelAll();
    Fluttertoast.showToast(
      msg: "全ての通知をキャンセルしました",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,);
  }

  Future<void> cancelNotification(
      int notificationId, String toastMessage) async {
    await flnp.cancel(notificationId);
    Fluttertoast.showToast(
      msg: "${toastMessage}の通知をキャンセルしました。",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,);
  }



  tz.TZDateTime _scheduledDate(Time time) {
    //TODO
    print("決まった時間に通知");
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    return scheduled.isBefore(now)
        ? scheduled.add(Duration(days: 1))
        : scheduled;
  }

  // Future<void> weekdayNotification(context, flnp, id, int weekDayOnDateTime, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //   final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //     weekTimeOfDay = setTime;
  //
  //     //通知のとこ
  //     setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekDayOnDateTime, stringWeekDay);
  //   }
  // }

  Future<void> setWeekNotification(
      id,
      hour, minutes, week, weekText) async {
    await flnp.zonedSchedule(
        id, //IDは被ると上書きされるので、他と違う物を
        'Title:$weekText${hour}時${minutes}分の通知', //行けたかも
        '本文：$weekTextに通知',
        _weekSchedule(Time(hour, minutes, 00), week),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'weekly notification channel id',
            'weekly notification channel name',
            channelDescription: 'weekly notificationdescription',
            color: Colors.blue, //アイコンの色設定
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: IOSNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime //毎週（同じ曜日と時刻）繰り返す。
    );
    Fluttertoast.showToast(
      msg: "${weekText}の${hour}時${minutes}分に登録完了しました",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,);
  }

  tz.TZDateTime _weekSchedule(Time time, week) {
    //スケジュール処理
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    while (scheduledDate.weekday != week) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }


  Future<TimeOfDay?> _everydayAndWeekdayCommonShowTimepicker(
      BuildContext context, initialTime) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: "通知する時間を設定してください",
      cancelText: "キャンセル",
      confirmText: "決定",
    );
  }

 // Future<void> everyDayNotification(BuildContext context, FlutterLocalNotificationsPlugin flnp, int id, TimeOfDay everyDayTimeOfDay, String toastText) async{
 //     final initialTime = everyDayTimeOfDay; //TODO 動作確認後消す
 //     final TimeOfDay? setTime =
 //         await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
 //     if (setTime != null) {
 //       everyDayTimeOfDay = setTime;
 //       setEveryDayNotification(flnp, id, setTime.hour, setTime.minute, toastText);
 //     }
 //  }

  Future<void> setEveryDayNotification( id, hour, minutes, toastText) async {
    await flnp.zonedSchedule(
        id, //IDは被ると上書きされるので、他と違う物を
        'Title:${hour}時${minutes}分に通知', //行けたかも
        '本文：決まった時間に通知',
        _scheduledDate(Time(hour, minutes, 00)),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'set Regularly',
            'set Regularly',
            color: Colors.blue, //アイコンの色設定
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: IOSNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time //毎日決まった時刻に繰り返す。
    );

    Fluttertoast.showToast(
      msg: "${toastText}${hour}時${minutes}分に通知します。",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,);
  }







  // //曜日ごとの通知
  // Future<void> setMondayNotification(
  //     context, flnp, id, int weekday, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //   final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //     weekTimeOfDay = setTime;
  //     setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekday, stringWeekDay);
  //   }
  // }
  //
  // Future<void> setTuesdayNotification(
  //     context, flnp, id, int weekday, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //     final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //   weekTimeOfDay = setTime;
  //   setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekday, stringWeekDay);
  //   }
  // }
  //
  // Future<void> setWednesdayNotification(
  //     context, flnp, id, int weekday, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //   final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //     weekTimeOfDay = setTime;
  //     setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekday, stringWeekDay);
  //   }
  // }
  //
  // Future<void> setThursdayNotification(
  //     context, flnp, id, int weekday, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //   final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //     weekTimeOfDay = setTime;
  //     setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekday, stringWeekDay);
  //   }
  // }
  //
  // Future<void> setFridayNotification(
  //     context, flnp, id, int weekday, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //   final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //     weekTimeOfDay = setTime;
  //     setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekday, stringWeekDay);
  //   }
  // }
  //
  // Future<void> setSaturdayNotification(
  //     context, flnp, id, int weekday, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //   final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //     weekTimeOfDay = setTime;
  //     setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekday, stringWeekDay);
  //   }
  // }
  //
  // Future<void> setSundayNotification(
  //     context, flnp, id, int weekday, String stringWeekDay, TimeOfDay weekTimeOfDay) async{
  //   final initialTime = weekTimeOfDay;
  //   final setTime =
  //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
  //   if (setTime != null) {
  //     weekTimeOfDay = setTime;
  //     setWeekNotification(flnp, id, setTime.hour, setTime.minute, weekday, stringWeekDay);
  //   }
  // }



}

