import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification/model/notification_repository.dart';
import 'package:local_notification/model/shared_prefs.dart';

class FlutterLocalNotificationViewModel extends ChangeNotifier {
  final FlutterLocalNotificationRepository flutterLocalNotificationRepository;

  final _sharedPrefsManager = SharedPrefsManager();

  FlutterLocalNotificationViewModel(
      {required this.flutterLocalNotificationRepository}) {
    // init();
  }
  DateTime now = DateTime.now();

  TimeOfDay everyDayTimeOfDay = TimeOfDay.now();
  TimeOfDay mondayTimeOfDay = TimeOfDay.now();
  TimeOfDay tuesdayTimeOfDay = TimeOfDay.now();
  TimeOfDay wednesdayTimeOfDay = TimeOfDay.now();
  TimeOfDay thursdayTimeOfDay = TimeOfDay.now();
  TimeOfDay fridayTimeOfDay = TimeOfDay.now();
  TimeOfDay saturdayTimeOfDay = TimeOfDay.now();
  TimeOfDay sundayTimeOfDay = TimeOfDay.now();

  String stringMondayTime = "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}";


  //曜日の設定
  var mondayDateTime = DateTime.monday;
  var tuesdayDateTime = DateTime.tuesday;
  var wednesdayDateTime = DateTime.wednesday;
  var thursdayDateTime = DateTime.thursday;
  var fridayDateTime = DateTime.friday;
  var saturdayDateTime = DateTime.saturday;
  var sundayDateTime = DateTime.sunday;

  //通知のID、被ると上書きされるので注意
  int mondayNotificationId = 1; //月曜日に通知ID
  int tuesdayNotificationId = 2; //火曜日に通知ID
  int wednesdayNotificationId = 3; //水曜日に通知ID
  int thursdayNotificationId = 4; //木曜日に通知ID
  int fridayNotificationId = 5; //金曜日に通知ID
  int saturdayNotificationId = 6; //土曜日に通知ID
  int sundayNotificationId = 7; //日曜日に通知ID
  int quicklyNotificationId = 8; //すぐに通知ID
  int threeSecondsNotificationId = 9; //3秒後通知ID
  int everyDayNotificationId = 10; //決まった時間に通知ID
  int repeatOneMinutesNotificationId = 11; //1分ごとに通知ID

  //通知のチェックボックス管理
  bool isMondayNotificationEnabled = false; //月曜日に通知チェックボックス
  bool isTuesdayNotificationEnabled = false; //火曜日に通知チェックボックス
  bool isWednesdayNotificationEnabled = false; //水曜日に通知チェックボックス
  bool isThursdayNotificationEnabled = false; //木曜日に通知チェックボックス
  bool isFridayNotificationEnabled = false; //金曜日に通知チェックボックス
  bool isSaturdayNotificationEnabled = false; //土曜日に通知チェックボックス
  bool isSundayNotificationEnabled = false; //日曜日に通知チェックボックス
  bool isQuicklyNotificationEnabled = false; //すぐに通知チェックボックス
  bool isThreeSecondsNotificationEnabled = false; //3秒後通知チェックボックス
  bool isEveryDayNotificationEnabled = false; //決まった時間に通知チェックボックス
  bool isRepeatOneMinutesNotificationEnabled = false; //1分ごとに通知チェックボックス

  final FlutterLocalNotificationsPlugin flnp =
      FlutterLocalNotificationsPlugin();

  // void init() async{
  //   isMondayNotificationEnabled = await _sharedPrefsManager.getBoolOnMonday();
  //   isTuesdayNotificationEnabled = await _sharedPrefsManager.getBoolOnTuesday();
  //   isWednesdayNotificationEnabled =
  //       await _sharedPrefsManager.getBoolOnWednesday();
  //   isThursdayNotificationEnabled =
  //       await _sharedPrefsManager.getBoolOnThursday();
  //   isFridayNotificationEnabled = await _sharedPrefsManager.getBoolOnFriday();
  //   isSaturdayNotificationEnabled =
  //       await _sharedPrefsManager.getBoolOnSaturday();
  //   isSundayNotificationEnabled = await _sharedPrefsManager.getBoolOnSunday();
  //   notifyListeners();
  // }

  // notificationEnabled(notificationEnabled, isChecked) {
  //   notificationEnabled = isChecked;
  //   notifyListeners();
  //   print("notificationEnabled:$notificationEnabled");
  // }

  Future<void> initTimeAndNotification(context) async {
    await flutterLocalNotificationRepository.initTimeAndNotification(
        context, flnp);
    notifyListeners();
  }

  Future<void> requestPermissionsOnIos() async {
    await flutterLocalNotificationRepository.requestPermissionsOnIos(flnp);
    notifyListeners();
  }

  Future<void> setNowNotification() async {
    await flutterLocalNotificationRepository.setNowNotification(
        flnp, quicklyNotificationId);
    notifyListeners();
  }

  Future<void> setRepeatOneMinutesNotification() async {
    await flutterLocalNotificationRepository.repeatOneMinutesNotification(
        flnp, repeatOneMinutesNotificationId);
    notifyListeners();
  }

  Future<void> setThreeSecondsNotification(
      {required BuildContext context}) async {
    await flutterLocalNotificationRepository.threeSecondsNotification(
        flnp, threeSecondsNotificationId, context);
    notifyListeners();
  }

  // Future<void> setWeekdayNotification(
  //     {required BuildContext context,
  //     required int id,
  //     required int DateTimeTypeOnWeekDay,
  //     required String stringWeekDayText,
  //     required TimeOfDay weekTimeOfDay}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(
  //       context, flnp, id, DateTimeTypeOnWeekDay, stringWeekDayText, weekTimeOfDay);
  // }

  Future<void> setEverydayNotification(
      {required hour, required minutes}) async {
    await flutterLocalNotificationRepository.setEveryDayNotification(
        flnp, everyDayNotificationId, hour, minutes);
    notifyListeners();
  }

  Future<void> setCancelAllNotification() async {
    await flutterLocalNotificationRepository.cancelAllNotification(flnp);
    isMondayNotificationEnabled = false;
    isTuesdayNotificationEnabled = false;
    isWednesdayNotificationEnabled = false;
    isThursdayNotificationEnabled = false;
    isFridayNotificationEnabled = false;
    isSaturdayNotificationEnabled = false;
    isSundayNotificationEnabled = false;
    isQuicklyNotificationEnabled = false;
    isThreeSecondsNotificationEnabled = false;
    isEveryDayNotificationEnabled = false;
    isRepeatOneMinutesNotificationEnabled = false;
    notifyListeners();
  }

  Future<void> setCancelNotification(
      {required int NotificationId, required String toastMessage}) async {
    await flutterLocalNotificationRepository.cancelNotification(
        flnp, NotificationId, toastMessage);
    notifyListeners();
  }

  //曜日ごとのBool値を保存
  // Future<void> mondaySharedPrefsSetBool(isChecked) async {
  //   await _sharedPrefsManager.setBoolOnMonday(isChecked);
  //   notifyListeners();
  // }
  //
  // Future<void> tuesdaySharedPrefsSetBool(isChecked) async {
  //   await _sharedPrefsManager.setBoolOnTuesday(isChecked);
  //   notifyListeners();
  // }
  //
  // Future<void> wednesdaySharedPrefsSetBool(isChecked) async {
  //   await _sharedPrefsManager.setBoolOnWednesday(isChecked);
  //   notifyListeners();
  // }
  //
  // Future<void> thursdaySharedPrefsSetBool(isChecked) async {
  //   await _sharedPrefsManager.setBoolOnThursday(isChecked);
  //   notifyListeners();
  // }
  //
  // Future<void> fridaySharedPrefsSetBool(isChecked) async {
  //   await _sharedPrefsManager.setBoolOnFriday(isChecked);
  //   notifyListeners();
  // }
  //
  // Future<void> saturdaySharedPrefsSetBool(isChecked) async {
  //   await _sharedPrefsManager.setBoolOnSaturday(isChecked);
  //   notifyListeners();
  // }
  //
  // Future<void> sundaySharedPrefsSetBool(isChecked) async {
  //   await _sharedPrefsManager.setBoolOnSunday(isChecked);
  //   notifyListeners();
  // }

  Future<void> mondaySharedPrefsGetBool() async {
    isMondayNotificationEnabled = await _sharedPrefsManager.getBoolOnMonday();
    notifyListeners();
  }


  Future<void> tuesdaySharedPrefsGetBool() async {
    isTuesdayNotificationEnabled = await _sharedPrefsManager.getBoolOnTuesday();
    print("tuesdaySharedPrefsGetBool:${isTuesdayNotificationEnabled}");
    notifyListeners();
  }


  Future<void> wednesdaySharedPrefsGetBool() async {
    isWednesdayNotificationEnabled =
        await _sharedPrefsManager.getBoolOnWednesday();
    notifyListeners();
  }


  Future<void> thursdaySharedPrefsGetBool() async {
    isThursdayNotificationEnabled =
        await _sharedPrefsManager.getBoolOnThursday();
    notifyListeners();
  }


  Future<void> fridaySharedPrefsGetBool() async {
    isFridayNotificationEnabled = await _sharedPrefsManager.getBoolOnFriday();
    notifyListeners();
  }


  Future<void> saturdaySharedPrefsGetBool() async {
    isSaturdayNotificationEnabled =
        await _sharedPrefsManager.getBoolOnSaturday();
    notifyListeners();
  }


  Future<void> sundaySharedPrefsGetBool() async {
    isSundayNotificationEnabled = await _sharedPrefsManager.getBoolOnSunday();
    notifyListeners();
  }

  //曜日ごとのTimeOfDay読み込み
  Future<void> mondaySharedPrefsGetTime() async {
    print("mondaySharedPrefsGetTime${_sharedPrefsManager.getTimeOnMonday()}");
    final timeOnMondayString = await _sharedPrefsManager.getTimeOnMonday(); //これはString
    // print("timeOnMondayString$timeOnMondayString"); //TimeOfDay(08:30)
    // String hour = timeOnMondayString.substring(10,12);//hour取れた
    // print(hour);//
    // String minute = timeOnMondayString.substring(13,15);//minute取れた
    // print(minute);//
    final timeOnMonday = DateTime.parse(timeOnMondayString);//StringをDateTimeに変換
    mondayTimeOfDay = await TimeOfDay.fromDateTime(timeOnMonday);
    print("mondaySharedPrefsGetTime$mondayTimeOfDay");
    // stringMondayTime = await _sharedPrefsManager.getTimeOnMonday();
    notifyListeners();
  }

  Future<void> tuesdaySharedPrefsGetTime() async {
    final timeOnTuesdayString = await _sharedPrefsManager.getTimeOnTuesday(); //StringをDateTime型へ
    final timeOnTuesday = DateTime.parse(timeOnTuesdayString);
    tuesdayTimeOfDay = await TimeOfDay.fromDateTime(timeOnTuesday);
    notifyListeners();
  }

  Future<void> wednesdaySharedPrefsGetTime() async {
    final timeOnWednesdayString = await _sharedPrefsManager.getTimeOnWednesday(); //StringをDateTime型へ
    final timeOnWednesday = DateTime.parse(timeOnWednesdayString);
    wednesdayTimeOfDay = await TimeOfDay.fromDateTime(timeOnWednesday);
    notifyListeners();
  }

  Future<void> thursdaySharedPrefsGetTime() async {
    final timeOnThursdayString = await _sharedPrefsManager.getTimeOnThursday(); //StringをDateTime型へ
    final timeOnThursday = DateTime.parse(timeOnThursdayString);
    thursdayTimeOfDay = await TimeOfDay.fromDateTime(timeOnThursday);
    notifyListeners();
  }

  Future<void> fridaySharedPrefsGetTime() async {
    final timeOnFridayString = await _sharedPrefsManager.getTimeOnFriday(); //StringをDateTime型へ
    final timeOnFriday = DateTime.parse(timeOnFridayString);
    fridayTimeOfDay = await TimeOfDay.fromDateTime(timeOnFriday);
    notifyListeners();
  }

  Future<void> saturdaySharedPrefsGetTime() async {
    final timeOnSaturdayString = await _sharedPrefsManager.getTimeOnSaturday(); //StringをDateTime型へ
    final timeOnSaturday = DateTime.parse(timeOnSaturdayString);
    saturdayTimeOfDay = await TimeOfDay.fromDateTime(timeOnSaturday);
    notifyListeners();
  }

  Future<void> sundaySharedPrefsGetTime() async {
    final timeOnSundayString = await _sharedPrefsManager.getTimeOnSunday(); //StringをDateTime型へ
    final timeOnSunday = DateTime.parse(timeOnSundayString);
    sundayTimeOfDay = await TimeOfDay.fromDateTime(timeOnSunday);
    notifyListeners();
  }

  // Future<void> mondaySharedPrefsSetTime(stringTimeOfDay) async {
  //   await _sharedPrefsManager.setTimeOnMonday(stringTimeOfDay.toString());
  //   notifyListeners();
  //   print("${stringTimeOfDay.toString()}");
  // }
  //
  // Future<void> tuesdaySharedPrefsSetTime(stringTimeOfDay) async {
  //   await _sharedPrefsManager.setTimeOnTuesday(stringTimeOfDay.toString());
  //   notifyListeners();
  // }
  //
  // Future<void> wednesdaySharedPrefsSetTime(stringTimeOfDay) async {
  //   await _sharedPrefsManager.setTimeOnWednesday(stringTimeOfDay.toString());
  //   notifyListeners();
  // }
  //
  // Future<void> thursdaySharedPrefsSetTime(stringTimeOfDay) async {
  //   await _sharedPrefsManager.setTimeOnThursday(stringTimeOfDay.toString());
  //   notifyListeners();
  // }
  //
  // Future<void> fridaySharedPrefsSetTime(stringTimeOfDay) async {
  //   await _sharedPrefsManager.setTimeOnFriday(stringTimeOfDay.toString());
  //   notifyListeners();
  // }
  //
  // Future<void> saturdaySharedPrefsSetTime(stringTimeOfDay) async {
  //   await _sharedPrefsManager.setTimeOnSaturday(stringTimeOfDay.toString());
  //   notifyListeners();
  // }
  //
  // Future<void> sundaySharedPrefsSetTime(stringTimeOfDay) async {
  //   await _sharedPrefsManager.setTimeOnSunday(stringTimeOfDay.toString());
  //   notifyListeners();
  // }

  // 曜日ごとの通知
  // Future<void> setMondayNotification({required BuildContext context}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(
  //       context, flnp, mondayNotificationId, monday, "月曜日", mondayTimeOfDay);
  //   notifyListeners();
  // }
  //
  // Future<void> setTuesdayNotification({required BuildContext context}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(
  //       context, flnp, tuesdayNotificationId, tuesday, "火曜日", tuesdayTimeOfDay);
  //   notifyListeners();
  // }
  //
  // Future<void> setWednesdayNotification({required BuildContext context}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(context, flnp,
  //       wednesdayNotificationId, wednesday, "水曜日", wednesdayTimeOfDay);
  //   notifyListeners();
  // }
  //
  // Future<void> setThursdayNotification({required BuildContext context}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(context, flnp,
  //       thursdayNotificationId, thursday, "木曜日", thursdayTimeOfDay);
  //   notifyListeners();
  // }
  //
  // Future<void> setFridayNotification({required BuildContext context}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(
  //       context, flnp, fridayNotificationId, friday, "金曜日", fridayTimeOfDay);
  //   notifyListeners();
  // }
  //
  // Future<void> setSaturdayNotification({required BuildContext context}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(context, flnp,
  //       saturdayNotificationId, saturday, "土曜日", saturdayTimeOfDay);
  //   notifyListeners();
  // }
  //
  // Future<void> setSundayNotification({required BuildContext context}) async {
  //   await flutterLocalNotificationRepository.weekdayNotification(
  //       context, flnp, sundayNotificationId, sunday, "日曜日", sundayTimeOfDay);
  //   notifyListeners();
  // }

  Future<void> setWeekday(
      id, int hour, int minute, weekDayOnDateTime, stringWeekDay) async {
    await flutterLocalNotificationRepository.setWeekNotification(
        flnp, id, hour, minute, weekDayOnDateTime, stringWeekDay);
  }

  void changeEveryDayTimeOfDay(TimeOfDay setTime) {
    everyDayTimeOfDay = setTime;
    notifyListeners();
  }

  void changeWeekdayText(dateTimeTypeOnWeekDay, setTime) async{
    if (dateTimeTypeOnWeekDay == mondayDateTime) {
      mondayTimeOfDay = setTime;
     // await _sharedPrefsManager.setTimeOnMonday(setTime);
     await _sharedPrefsManager.setTimeOnMonday(_saveTime(setTime));
    } else if (dateTimeTypeOnWeekDay == tuesdayDateTime) {
      tuesdayTimeOfDay = setTime;
      await _sharedPrefsManager.setTimeOnTuesday(_saveTime(setTime).toString());
    } else if (dateTimeTypeOnWeekDay == wednesdayDateTime) {
      wednesdayTimeOfDay = setTime;
      await _sharedPrefsManager.setTimeOnWednesday(_saveTime(setTime).toString());
    } else if (dateTimeTypeOnWeekDay == thursdayDateTime) {
      thursdayTimeOfDay = setTime;
      await _sharedPrefsManager.setTimeOnThursday(_saveTime(setTime).toString());
    } else if (dateTimeTypeOnWeekDay == fridayDateTime) {
      fridayTimeOfDay = setTime;
      await _sharedPrefsManager.setTimeOnFriday(_saveTime(setTime).toString());
    } else if (dateTimeTypeOnWeekDay == saturdayDateTime) {
      saturdayTimeOfDay = setTime;
      await _sharedPrefsManager.setTimeOnSaturday(_saveTime(setTime).toString());
    } else if (dateTimeTypeOnWeekDay == sundayDateTime) {
      sundayTimeOfDay = setTime;
      await _sharedPrefsManager.setTimeOnSunday(_saveTime(setTime).toString());
    }
    notifyListeners();
  }

  void notificationCheckUpdate(dateTimeTypeOnWeekDay, isChecked) async{
    if (dateTimeTypeOnWeekDay == mondayDateTime) {
      isMondayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnMonday(isChecked);
    } else if (dateTimeTypeOnWeekDay == tuesdayDateTime) {
      isTuesdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnTuesday(isChecked);
    } else if (dateTimeTypeOnWeekDay == wednesdayDateTime) {
      isWednesdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnWednesday(isChecked);
    } else if (dateTimeTypeOnWeekDay == thursdayDateTime) {
      isThursdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnThursday(isChecked);
    } else if (dateTimeTypeOnWeekDay == fridayDateTime) {
      isFridayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnFriday(isChecked);
    } else if (dateTimeTypeOnWeekDay == DateTime.saturday) {
      isSaturdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnSaturday(isChecked);
    } else if (dateTimeTypeOnWeekDay == sundayDateTime) {
      isSundayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnSunday(isChecked);
    }
    notifyListeners();
  }

  _saveTime(setTime) {
    DateTime(
      now.year,//DateTime
      now.month,//DateTime
      now.day,//DateTime
      setTime.hour, // TimeOfDay
      setTime.minute, //TimeOfDay
    ).toString();
  }

  // void changeText() { //test
//   text = 'テキストが変わった';
//   notifyListeners();
// }

// void changeText(weekTimeOfDay, TimeOfDay setTime) {
//   weekTimeOfDay = setTime;
//   notifyListeners();
// }

// void changeTest(TimeOfDay setTime) { //test
//   test = setTime;
//   notifyListeners();
// }

}
