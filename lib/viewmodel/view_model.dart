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
      {required this.flutterLocalNotificationRepository});

  TimeOfDay everyDayTimeOfDay = TimeOfDay.now();
  TimeOfDay mondayTimeOfDay = TimeOfDay.now();
  TimeOfDay tuesdayTimeOfDay = TimeOfDay.now();
  TimeOfDay wednesdayTimeOfDay = TimeOfDay.now();
  TimeOfDay thursdayTimeOfDay = TimeOfDay.now();
  TimeOfDay fridayTimeOfDay = TimeOfDay.now();
  TimeOfDay saturdayTimeOfDay = TimeOfDay.now();
  TimeOfDay sundayTimeOfDay = TimeOfDay.now();

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

  // notificationEnabled(isChecked)  {
  //   isMondayNotificationEnabled = isChecked;
  //   notifyListeners();
  // }

  notificationEnabled(notificationEnabled, isChecked) {
    notificationEnabled = isChecked;
    notifyListeners();
    print("notificationEnabled:$notificationEnabled");
  }

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
  Future<void> mondaySharedPrefsGetBool() async {
    isMondayNotificationEnabled = await _sharedPrefsManager.getBoolOnMonday();
    notifyListeners();
  }

  Future<void> mondaySharedPrefsSetBool(isChecked) async {
    await _sharedPrefsManager.setBoolOnMonday(isChecked);
    notifyListeners();
  }

  Future<void> tuesdaySharedPrefsGetBool() async {
    isTuesdayNotificationEnabled = await _sharedPrefsManager.getBoolOnTuesday();
    notifyListeners();
  }

  Future<void> tuesdaySharedPrefsSetBool(isChecked) async {
    await _sharedPrefsManager.setBoolOnTuesday(isChecked);
    notifyListeners();
  }

  Future<void> wednesdaySharedPrefsGetBool() async {
    isWednesdayNotificationEnabled =
        await _sharedPrefsManager.getBoolOnWednesday();
    notifyListeners();
  }

  Future<void> wednesdaySharedPrefsSetBool(isChecked) async {
    await _sharedPrefsManager.setBoolOnWednesday(isChecked);
    notifyListeners();
  }

  Future<void> thursdaySharedPrefsGetBool() async {
    isThursdayNotificationEnabled =
        await _sharedPrefsManager.getBoolOnThursday();
    notifyListeners();
  }

  Future<void> thursdaySharedPrefsSetBool(isChecked) async {
    await _sharedPrefsManager.setBoolOnThursday(isChecked);
    notifyListeners();
  }

  Future<void> fridaySharedPrefsGetBool() async {
    isFridayNotificationEnabled = await _sharedPrefsManager.getBoolOnFriday();
    notifyListeners();
  }

  Future<void> fridaySharedPrefsSetBool(isChecked) async {
    await _sharedPrefsManager.setBoolOnFriday(isChecked);
    notifyListeners();
  }

  Future<void> saturdaySharedPrefsGetBool() async {
    isSaturdayNotificationEnabled =
        await _sharedPrefsManager.getBoolOnSaturday();
    notifyListeners();
  }

  Future<void> saturdaySharedPrefsSetBool(isChecked) async {
    await _sharedPrefsManager.setBoolOnSaturday(isChecked);
    notifyListeners();
  }

  Future<void> sundaySharedPrefsGetBool() async {
    isSundayNotificationEnabled = await _sharedPrefsManager.getBoolOnSunday();
    notifyListeners();
  }

  Future<void> sundaySharedPrefsSetBool(isChecked) async {
    await _sharedPrefsManager.setBoolOnSunday(isChecked);
    notifyListeners();
  }

  //曜日ごとのTimeOfDay保存と読み込み
  Future<void> mondaySharedPrefsGetTime() async {
    //print("${_sharedPrefsManager.getTimeOnMonday()}");
    final timeOnMondayString = await _sharedPrefsManager.getTimeOnMonday();
    final timeOnMonday = DateTime.parse(timeOnMondayString);
    mondayTimeOfDay = await TimeOfDay.fromDateTime(timeOnMonday);
    print(mondayTimeOfDay);
    notifyListeners();
  }

  Future<void> tuesdaySharedPrefsGetTime() async {
    tuesdayTimeOfDay = await TimeOfDay.fromDateTime(
        DateTime.parse(_sharedPrefsManager.getTimeOnTuesday().toString()));
    notifyListeners();
  }

  Future<void> wednesdaySharedPrefsGetTime() async {
    wednesdayTimeOfDay = await TimeOfDay.fromDateTime(
        DateTime.parse(_sharedPrefsManager.getTimeOnWednesday().toString()));
    notifyListeners();
  }

  Future<void> thursdaySharedPrefsGetTime() async {
    thursdayTimeOfDay = await TimeOfDay.fromDateTime(
        DateTime.parse(_sharedPrefsManager.getTimeOnThursday().toString()));
    ;
    notifyListeners();
  }

  Future<void> fridaySharedPrefsGetTime() async {
    fridayTimeOfDay = await TimeOfDay.fromDateTime(
        DateTime.parse(_sharedPrefsManager.getTimeOnFriday().toString()));
    notifyListeners();
  }

  Future<void> saturdaySharedPrefsGetTime() async {
    saturdayTimeOfDay = await TimeOfDay.fromDateTime(
        DateTime.parse(_sharedPrefsManager.getTimeOnSaturday().toString()));
    notifyListeners();
  }

  Future<void> sundaySharedPrefsGetTime() async {
    sundayTimeOfDay = await TimeOfDay.fromDateTime(
        DateTime.parse(_sharedPrefsManager.getTimeOnSunday().toString()));
    notifyListeners();
  }

  Future<void> mondaySharedPrefsSetTime(stringTimeOfDay) async {
    await _sharedPrefsManager.setTimeOnMonday(stringTimeOfDay.toString());
    notifyListeners();
    print("${stringTimeOfDay.toString()}");
  }

  Future<void> tuesdaySharedPrefsSetTime(stringTimeOfDay) async {
    await _sharedPrefsManager.setTimeOnTuesday(stringTimeOfDay.toString());
    notifyListeners();
  }

  Future<void> wednesdaySharedPrefsSetTime(stringTimeOfDay) async {
    await _sharedPrefsManager.setTimeOnWednesday(stringTimeOfDay.toString());
    notifyListeners();
  }

  Future<void> thursdaySharedPrefsSetTime(stringTimeOfDay) async {
    await _sharedPrefsManager.setTimeOnThursday(stringTimeOfDay.toString());
    notifyListeners();
  }

  Future<void> fridaySharedPrefsSetTime(stringTimeOfDay) async {
    await _sharedPrefsManager.setTimeOnFriday(stringTimeOfDay.toString());
    notifyListeners();
  }

  Future<void> saturdaySharedPrefsSetTime(stringTimeOfDay) async {
    await _sharedPrefsManager.setTimeOnSaturday(stringTimeOfDay.toString());
    notifyListeners();
  }

  Future<void> sundaySharedPrefsSetTime(stringTimeOfDay) async {
    await _sharedPrefsManager.setTimeOnSunday(stringTimeOfDay.toString());
    notifyListeners();
  }

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

  void changeWeekdayText(dateTimeTypeOnWeekDay, setTime) {
    if (dateTimeTypeOnWeekDay == mondayDateTime) {
      mondayTimeOfDay = setTime;
    } else if (dateTimeTypeOnWeekDay == tuesdayDateTime) {
      tuesdayTimeOfDay = setTime;
    } else if (dateTimeTypeOnWeekDay == wednesdayDateTime) {
      wednesdayTimeOfDay = setTime;
    } else if (dateTimeTypeOnWeekDay == thursdayDateTime) {
      thursdayTimeOfDay = setTime;
    } else if (dateTimeTypeOnWeekDay == fridayDateTime) {
      fridayTimeOfDay = setTime;
    } else if (dateTimeTypeOnWeekDay == saturdayDateTime) {
      saturdayTimeOfDay = setTime;
    } else if (dateTimeTypeOnWeekDay == sundayDateTime) {
      sundayTimeOfDay = setTime;
    }
    notifyListeners();
  }

  void notificationCheckUpdate(dateTimeTypeOnWeekDay, value) {
    if (dateTimeTypeOnWeekDay == mondayDateTime) {
      isMondayNotificationEnabled = value;
    } else if (dateTimeTypeOnWeekDay == tuesdayDateTime) {
      isTuesdayNotificationEnabled = value;
    } else if (dateTimeTypeOnWeekDay == wednesdayDateTime) {
      isWednesdayNotificationEnabled = value;
    } else if (dateTimeTypeOnWeekDay == thursdayDateTime) {
      isThursdayNotificationEnabled = value;
    } else if (dateTimeTypeOnWeekDay == fridayDateTime) {
      isFridayNotificationEnabled = value;
    } else if (dateTimeTypeOnWeekDay == DateTime.saturday) {
      isSaturdayNotificationEnabled = value;
    } else if (dateTimeTypeOnWeekDay == sundayDateTime) {
      isSundayNotificationEnabled = value;
    }
    notifyListeners();
  }

  void setBool(weekday, bool bool) {
    if (weekday == mondayDateTime) {
      isMondayNotificationEnabled = bool;
    } else if (weekday == tuesdayDateTime) {
      isTuesdayNotificationEnabled = bool;
    }
    if (weekday == wednesdayDateTime) {
      isWednesdayNotificationEnabled = bool;
    } else if (weekday == thursdayDateTime) {
      isThursdayNotificationEnabled = bool;
    } else if (weekday == fridayDateTime) {
      isFridayNotificationEnabled = bool;
    } else if (weekday == saturdayDateTime) {
      isSaturdayNotificationEnabled = bool;
    } else if (weekday == sundayDateTime) {
      isSundayNotificationEnabled = bool;
    }
    notifyListeners();
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
