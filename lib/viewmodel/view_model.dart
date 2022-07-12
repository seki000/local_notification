import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification/model/notification_repository.dart';
import 'package:local_notification/model/shared_prefs.dart';


enum NotificationType {EVERYDAY, WEEKDAY}

class FlutterLocalNotificationViewModel extends ChangeNotifier {
  final FlutterLocalNotificationRepository flutterLocalNotificationRepository;

  final _sharedPrefsManager = SharedPrefsManager();

  FlutterLocalNotificationViewModel(
      {required this.flutterLocalNotificationRepository}) {
    init();
  }

  DateTime everyDayDateTime = DateTime.now();
  DateTime mondayDateTime = DateTime.now();
  DateTime tuesdayDateTime = DateTime.now();
  DateTime wednesdayDateTime = DateTime.now();
  DateTime thursdayDateTime = DateTime.now();
  DateTime fridayDateTime = DateTime.now();
  DateTime saturdayDateTime = DateTime.now();
  DateTime sundayDateTime = DateTime.now();

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

  // final FlutterLocalNotificationsPlugin flnp =
  //     FlutterLocalNotificationsPlugin();

  

  Future<void> initTimeAndNotification(context) async {
    await flutterLocalNotificationRepository.initTimeAndNotification(
        context);
    notifyListeners();
  }

  Future<void> requestPermissionsOnIos() async {
    await flutterLocalNotificationRepository.requestPermissionsOnIos();
    notifyListeners();
  }

  Future<void> setNowNotification() async {
    await flutterLocalNotificationRepository.setNowNotification(
        quicklyNotificationId);
    notifyListeners();
  }

  Future<void> setRepeatOneMinutesNotification() async {
    await flutterLocalNotificationRepository.repeatOneMinutesNotification(
         repeatOneMinutesNotificationId);
    notifyListeners();
  }

  Future<void> setThreeSecondsNotification(
      {required BuildContext context}) async {
    await flutterLocalNotificationRepository.threeSecondsNotification(
         threeSecondsNotificationId, context);
    notifyListeners();
  }

  Future<void> setEverydayNotification(
      {required id, required hour, required minutes, required toastText}) async {
    await flutterLocalNotificationRepository.setEveryDayNotification(
         id, hour, minutes, toastText);
    notifyListeners();
  }

  Future<void> setCancelAllNotification() async {
    await flutterLocalNotificationRepository.cancelAllNotification();
    isMondayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnMonday(false);
    isTuesdayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnTuesday(false);
    isWednesdayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnWednesday(false);
    isThursdayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnThursday(false);
    isFridayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnFriday(false);
    isSaturdayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnSaturday(false);
    isSundayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnSunday(false);
    isEveryDayNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnEveryday(false);

    isQuicklyNotificationEnabled = false;
    isThreeSecondsNotificationEnabled = false;
    isRepeatOneMinutesNotificationEnabled = false;
    _sharedPrefsManager.setBoolOnRepeat(false);

    notifyListeners();
  }

  Future<void> setCancelNotification(
      {required int NotificationId, required String toastMessage}) async {
    await flutterLocalNotificationRepository.cancelNotification(
         NotificationId, toastMessage);
    notifyListeners();
  }



  Future<void> setWeekday(
      id, int hour, int minute, weekDayOnDateTime, stringWeekDay) async {
    await flutterLocalNotificationRepository.setWeekNotification(
         id, hour, minute, weekDayOnDateTime, stringWeekDay);
  }

  void changeWeekdayTime(weekDay, setTime) async{
    if (weekDay == DateTime.monday) {
      mondayDateTime = setTime;
     await _sharedPrefsManager.setTimeOnMonday(setTime.toString());
    } else if (weekDay == DateTime.tuesday) {
      tuesdayDateTime = setTime;
      await _sharedPrefsManager.setTimeOnTuesday(setTime.toString());
    } else if (weekDay == DateTime.wednesday) {
      wednesdayDateTime = setTime;
      await _sharedPrefsManager.setTimeOnWednesday(setTime.toString());
    } else if (weekDay == DateTime.thursday) {
      thursdayDateTime = setTime;
      await _sharedPrefsManager.setTimeOnThursday(setTime.toString());
    } else if (weekDay == DateTime.friday) {
      fridayDateTime = setTime;
      await _sharedPrefsManager.setTimeOnFriday(setTime.toString());
    } else if (weekDay == DateTime.saturday) {
      saturdayDateTime = setTime;
      await _sharedPrefsManager.setTimeOnSaturday(setTime.toString());
    } else if (weekDay == DateTime.sunday) {
      sundayDateTime = setTime;
      await _sharedPrefsManager.setTimeOnSunday(setTime.toString());
    }else if (weekDay == null) {
      everyDayDateTime = setTime;
      await _sharedPrefsManager.setTimeOnEveryday(setTime.toString());
    }
    notifyListeners();
  }

  void notificationCheckUpdate(dateTimeTypeOnWeekDay, isChecked) async{
    if (dateTimeTypeOnWeekDay == DateTime.monday) {
      isMondayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnMonday(isChecked);
    } else if (dateTimeTypeOnWeekDay == DateTime.tuesday) {
      isTuesdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnTuesday(isChecked);
    } else if (dateTimeTypeOnWeekDay == DateTime.wednesday) {
      isWednesdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnWednesday(isChecked);
    } else if (dateTimeTypeOnWeekDay == DateTime.thursday) {
      isThursdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnThursday(isChecked);
    } else if (dateTimeTypeOnWeekDay == DateTime.friday) {
      isFridayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnFriday(isChecked);
    } else if (dateTimeTypeOnWeekDay == DateTime.saturday) {
      isSaturdayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnSaturday(isChecked);
    } else if (dateTimeTypeOnWeekDay == DateTime.sunday) {
      isSundayNotificationEnabled = isChecked;
        await _sharedPrefsManager.setBoolOnSunday(isChecked);
    }else if(dateTimeTypeOnWeekDay == null){ //毎日通知はDateTimeのWeekdayがないのでNull
      isEveryDayNotificationEnabled = isChecked;
      await _sharedPrefsManager.setBoolOnEveryday(isChecked);
    }
    notifyListeners();
  }

  Future<void> repeatNotificationCheckUpdate(isChecked) async {
    isRepeatOneMinutesNotificationEnabled = isChecked;
    await  _sharedPrefsManager.setBoolOnRepeat(isChecked);
  notifyListeners();
  }

    void init() async{
    //通知のチェック読み込み
    isMondayNotificationEnabled = await _sharedPrefsManager.getBoolOnMonday();
    isTuesdayNotificationEnabled = await _sharedPrefsManager.getBoolOnTuesday();
    isWednesdayNotificationEnabled = await _sharedPrefsManager.getBoolOnWednesday();
    isThursdayNotificationEnabled = await _sharedPrefsManager.getBoolOnThursday();
    isFridayNotificationEnabled = await _sharedPrefsManager.getBoolOnFriday();
    isSaturdayNotificationEnabled = await _sharedPrefsManager.getBoolOnSaturday();
    isSundayNotificationEnabled = await _sharedPrefsManager.getBoolOnSunday();
    isEveryDayNotificationEnabled = await _sharedPrefsManager.getBoolOnEveryday();
    isRepeatOneMinutesNotificationEnabled = await _sharedPrefsManager.getBoolOnRepeat();

    //通知の時間読み込み
    final timeOnMondayString = await _sharedPrefsManager.getTimeOnMonday(); //StringをDateTime型へ
    mondayDateTime = await DateTime.parse(timeOnMondayString);

    final timeOnTuesdayString = await _sharedPrefsManager.getTimeOnTuesday(); //StringをDateTime型へ
    tuesdayDateTime = await DateTime.parse(timeOnTuesdayString);

    final timeOnWednesdayString = await _sharedPrefsManager.getTimeOnWednesday(); //StringをDateTime型へ
    wednesdayDateTime = await DateTime.parse(timeOnWednesdayString);

    final timeOnThursdayString = await _sharedPrefsManager.getTimeOnThursday(); //StringをDateTime型へ
    thursdayDateTime = await DateTime.parse(timeOnThursdayString);

    final timeOnFridayString = await _sharedPrefsManager.getTimeOnFriday(); //StringをDateTime型へ
    fridayDateTime = await DateTime.parse(timeOnFridayString);

    final timeOnSaturdayString = await _sharedPrefsManager.getTimeOnSaturday(); //StringをDateTime型へ
    saturdayDateTime = await DateTime.parse(timeOnSaturdayString);

    final timeOnSundayString = await _sharedPrefsManager.getTimeOnSunday(); //StringをDateTime型へ
    sundayDateTime = await DateTime.parse(timeOnSundayString);

    final timeOnEverydayString = await _sharedPrefsManager.getTimeOnEveryday(); //StringをDateTime型へ
    everyDayDateTime = await DateTime.parse(timeOnEverydayString);
    notifyListeners();

  }



}
