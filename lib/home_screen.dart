import 'package:flutter/material.dart';
import 'package:local_notification/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var testDateTime = DateTime.now(); //TODO 後で消す
  var testTimeOfDay = TimeOfDay.now(); //TODO 後で消す


  @override
  void initState() {
    super.initState();
    final vm = context.read<FlutterLocalNotificationViewModel>();
    vm.initTimeAndNotification(context);
    vm.requestPermissionsOnIos();
    initSharePrefs();
  }

  Widget build(BuildContext context) {
    return Consumer<FlutterLocalNotificationViewModel>(
      builder: (context, vm, child) {
        //final vm = context.watch<FlutterLocalNotificationViewModel>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              // CheckboxListTile(
              //     title: Text("月曜日に通知"),
              //     subtitle: _changeSubTitleSecond(
              //       isNotificationEnabled: vm.isMondayNotificationEnabled,
              //       weekTimeOfDay: vm.stringMondayTime,
              //     ),
              //     value: vm.isMondayNotificationEnabled,
              //     onChanged: (isChecked) async {
              //       vm.isMondayNotificationEnabled = isChecked!; //TODO これは変わる
              //       if (vm.isMondayNotificationEnabled == true) {
              //         //チェックがついたとき、通知ON
              //         await _weekdayOnTimepicker(
              //             context,
              //             vm.mondayTimeOfDay,
              //             vm.mondayNotificationId,
              //             DateTime.monday,
              //             "月曜日",
              //             vm.isMondayNotificationEnabled);
              //         // vm.mondaySharedPrefsSetBool(true);
              //       } else {
              //         //チェックが外れているとき、通知OFF（キャンセル）
              //         await vm.setCancelNotification(
              //             NotificationId: vm.mondayNotificationId,
              //             toastMessage: "月曜日");
              //         // vm.mondaySharedPrefsSetBool(false);
              //       }
              //     }
              //     ),
              _notificationCheckListTile(
                  isNotificationEnabled: vm.isMondayNotificationEnabled,
                  weekOrEverydayTimeOfDay: vm.mondayTimeOfDay,
                  dateTimeWeekday: vm.mondayDateTime,
                  stringMessageText: "月曜日",
                  notificationId: vm.mondayNotificationId,
                  enumType: NotificationType.WEEKDAY,
              ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isTuesdayNotificationEnabled,
                weekOrEverydayTimeOfDay: vm.tuesdayTimeOfDay,
                dateTimeWeekday: vm.tuesdayDateTime,
                stringMessageText: "火曜日",
                notificationId: vm.tuesdayNotificationId,
                enumType: NotificationType.WEEKDAY,
              ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isWednesdayNotificationEnabled,
                weekOrEverydayTimeOfDay: vm.wednesdayTimeOfDay,
                dateTimeWeekday: vm.wednesdayDateTime,
                stringMessageText: "水曜日",
                notificationId: vm.wednesdayNotificationId,
                enumType: NotificationType.WEEKDAY,
              ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isThursdayNotificationEnabled,
                weekOrEverydayTimeOfDay: vm.thursdayTimeOfDay,
                dateTimeWeekday: vm.thursdayDateTime,
                stringMessageText: "木曜日",
                notificationId: vm.thursdayNotificationId,
                enumType: NotificationType.WEEKDAY,
              ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isFridayNotificationEnabled,
                weekOrEverydayTimeOfDay: vm.fridayTimeOfDay,
                dateTimeWeekday: vm.fridayDateTime,
                stringMessageText: "金曜日",
                notificationId: vm.fridayNotificationId,
                enumType: NotificationType.WEEKDAY,
              ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isSaturdayNotificationEnabled,
                weekOrEverydayTimeOfDay: vm.saturdayTimeOfDay,
                dateTimeWeekday: vm.saturdayDateTime,
                stringMessageText: "土曜日",
                notificationId: vm.saturdayNotificationId,
                enumType: NotificationType.WEEKDAY,
              ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isSundayNotificationEnabled,
                weekOrEverydayTimeOfDay: vm.sundayTimeOfDay,
                dateTimeWeekday: vm.sundayDateTime,
                stringMessageText: "日曜日",
                notificationId: vm.sundayNotificationId,
                enumType: NotificationType.WEEKDAY,
              ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isEveryDayNotificationEnabled,
                weekOrEverydayTimeOfDay: vm.everyDayTimeOfDay,
                //毎日通知は曜日いらない
                stringMessageText: "毎日",
                notificationId: vm.everyDayNotificationId,
                enumType: NotificationType.EVERYDAY,
              ),
              ListTile(
                title: Text("全ての通知をキャンセルする"),
                leading: Icon(Icons.cancel_outlined),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (_) =>
                          _cancelAllAndDialog()
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      "1分ごとにリピート通知",
                    ),
                    onPressed: () async {
                      vm.setRepeatOneMinutesNotification();
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        vm.setCancelNotification(
                            NotificationId: vm.repeatOneMinutesNotificationId,
                            toastMessage: "リピート");
                      },
                      child: Text("リピート通知キャンセル")),
                ],
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await vm.setNowNotification();
                    },
                    child: Text("すぐに通知")),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      // await threeSecondsNotification();
                      await vm.setThreeSecondsNotification(context: context);
                    },
                    child: Text("3秒後に通知(色々実験)")),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ElevatedButton(
                  //   child: Text(
                  //     '毎日通知',
                  //   ),
                  //   onPressed: () async {
                  //     return _everydayOnTimepicker();
                  //   },
                  // ),
                  Text("vm.everyDay${vm.everyDayTimeOfDay.toString()}"),
                ],
              ),

              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) =>
                        _cancelAllAndDialog()
                                );
                    // vm.setCancelAllNotification();
                  },
                  child: Text("全ての通知をキャンセル")),
            ]),
          ),
        );
      },
    );
  }


  Future<void> _everydayOnTimepicker({
    required weekdayTimeOfDay,
    required id,
    required stringWeekDayText,
    required notificationEnabled,
}
     ) async {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    final setTime =
    await _everydayAndWeekdayCommonTimePicker(vm.everyDayTimeOfDay);
    if (setTime != null) {
      vm.changeEveryDayTimeOfDay(setTime);
      vm.setEverydayNotification(
          id: id,
          hour: setTime.hour,
          minutes: setTime.minute,
          toastText: stringWeekDayText
      );
      //setTime（タイムピッカー）で何か設定したらtrue
      // vm.everydayNotificationCheckUpdate(true);
    } else if (setTime == null) {
      //setTime（タイムピッカー）で何も設定しなかったたらFalse
      vm.notificationCheckUpdate(null, false);
    }
  }

  Future<void> _weekdayOnTimepicker(// context,
      weekdayTimeOfDay,
      id,
      WeekdayDateTime,
      stringWeekDayText,
      // notificationEnabled,
      ) async {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    final setTime =
          await _everydayAndWeekdayCommonTimePicker(weekdayTimeOfDay);
    if (setTime != null) {
      //setTime（タイムピッカー）で何か設定したらtrue
      vm.changeWeekdayText(WeekdayDateTime, setTime);
      vm.setWeekday(
          id, setTime.hour, setTime.minute, WeekdayDateTime, stringWeekDayText);

      // vm.notificationCheckUpdate(WeekdayDateTime, true);
    } else if (setTime == null) {
      //setTime（タイムピッカー）で何も設定しなかったたらFalse
      vm.notificationCheckUpdate(WeekdayDateTime, false);
    }
  }

  Future<TimeOfDay?> _everydayAndWeekdayCommonTimePicker(time) async {
    return await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: "通知する時間を設定してください",
      cancelText: "キャンセル",
      confirmText: "決定",
    );
  }

  _changeSubTitle(
      {required bool isNotificationEnabled, required TimeOfDay weekTimeOfDay}) {
    return isNotificationEnabled
        ? Text("通知する時間:${weekTimeOfDay.hour}時${weekTimeOfDay.minute}分")
        : Text("通知なし");
  }


  void initSharePrefs() {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    vm.mondaySharedPrefsGetBool();
    // print("mondaySharedPrefsGetBool${vm.mondaySharedPrefsGetBool}");
    vm.tuesdaySharedPrefsGetBool();
    vm.wednesdaySharedPrefsGetBool();
    vm.thursdaySharedPrefsGetBool();
    vm.fridaySharedPrefsGetBool();
    vm.saturdaySharedPrefsGetBool();
    vm.sundaySharedPrefsGetBool();
    vm.everydaySharedPrefsGetBool();
    vm.mondaySharedPrefsGetTime();
    // print("mondaySharedPrefsGetTime${vm.mondaySharedPrefsGetTime}");
    print("testDateTime$testDateTime");
    testTimeOfDay = TimeOfDay.fromDateTime(testDateTime);
    print("testTimeOfDay$testTimeOfDay");
    // vm.tuesdaySharedPrefsGetTime();
    // vm.wednesdaySharedPrefsGetTime();
    // vm.thursdaySharedPrefsGetTime();
    // vm.fridaySharedPrefsGetTime();
    // vm.saturdaySharedPrefsGetTime();
    // vm.sundaySharedPrefsGetTime();

    // String timeOnMondayString = "TimeOfDay(08:30)";
//   final timeOnMonday = DateTime.parse(timeOnMondayString);
//   print(timeOnMonday);
  }

  Widget _notificationCheckListTile({
    required isNotificationEnabled,
    required weekOrEverydayTimeOfDay,
     dateTimeWeekday,
    required stringMessageText,
    required notificationId,
    required enumType,
  }) {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    return CheckboxListTile(
        title: Text(stringMessageText),
        subtitle: _changeSubTitle(
          isNotificationEnabled: isNotificationEnabled,
          weekTimeOfDay: weekOrEverydayTimeOfDay,
        ),
        activeColor: Colors.red,
        checkColor: Colors.white,
        secondary: Icon(Icons.notifications,
          color: isNotificationEnabled ? Colors.red : Colors.grey,
          // color: Colors.red,
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        value: isNotificationEnabled,
        onChanged: (isChecked) async {
          isNotificationEnabled = isChecked!;
          vm.notificationCheckUpdate(dateTimeWeekday, isChecked);
          if (enumType == NotificationType.EVERYDAY) {
            if (isNotificationEnabled == true) {
              //チェックがついたとき、通知ON
              await _everydayOnTimepicker(
                  weekdayTimeOfDay: weekOrEverydayTimeOfDay,
                  id: notificationId,
                  stringWeekDayText: stringMessageText,
                  notificationEnabled: isNotificationEnabled);
            } else if (isNotificationEnabled == false){
              //チェックが外れているとき、通知OFF（キャンセル）
              await vm.setCancelNotification(
                  NotificationId: notificationId,
                  toastMessage: stringMessageText);
            }
          } else if (enumType == NotificationType.WEEKDAY) {
            if (isNotificationEnabled == true) {
              //チェックがついたとき、通知ON
              await _weekdayOnTimepicker(
                weekOrEverydayTimeOfDay,
                notificationId,
                dateTimeWeekday,
                stringMessageText,
              );
            } else {
              //チェックが外れているとき、通知OFF（キャンセル）
              await vm.setCancelNotification(
                  NotificationId: notificationId,
                  toastMessage: stringMessageText);
            }
          }
        }
    );
  }

  _cancelAllAndDialog() {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    return AlertDialog(
      title: Text(
        "全ての通知をキャンセルしますか？",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed:  (){
              vm.setCancelAllNotification();
              Navigator.pop(context);
            },
            child: Text("はい"),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("いいえ"))
        ],
      ),
    );
  }
}


