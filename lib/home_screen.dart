import 'package:flutter/material.dart';
import 'package:local_notification/parts/custom_checkboxListTile.dart';
import 'package:local_notification/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
              // CustomCheckBoxListTile(
              //     titleText: Text("月曜日に通知"),
              //     timeSubtitle: _changeSubTitle(
              //       isNotificationEnabled: vm.isMondayNotificationEnabled,
              //       weekTimeOfDay: vm.mondayTimeOfDay,
              //     ),
              //     isNotificationEnabled: vm.isMondayNotificationEnabled,
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
              //         vm.mondaySharedPrefsSetBool(true);
              //       } else {
              //         //チェックが外れているとき、通知OFF（キャンセル）
              //         await vm.setCancelNotification(
              //             NotificationId: vm.mondayNotificationId,
              //             toastMessage: "月曜日");
              //         vm.mondaySharedPrefsSetBool(false);
              //       }
              //     }
              //     ),
              _notificationCheckListTile(
                isNotificationEnabled: vm.isMondayNotificationEnabled,
                TimeOfDayOnWeek: vm.mondayTimeOfDay,
                dateTimeWeekday: vm.mondayDateTime,
                stringWeekday: "火曜日",
                notificationId: vm.mondayNotificationId,
                setBoolTrue: vm.mondaySharedPrefsSetBool(true),
                setBoolFalse: vm.mondaySharedPrefsSetBool(false),
              ),
              _notificationCheckListTile(
                  isNotificationEnabled: vm.isTuesdayNotificationEnabled,
                  TimeOfDayOnWeek: vm.tuesdayTimeOfDay,
                  dateTimeWeekday: vm.tuesdayDateTime,
                  stringWeekday: "火曜日",
                  notificationId: vm.tuesdayNotificationId,
                  setBoolTrue: vm.tuesdaySharedPrefsSetBool(true),
                  setBoolFalse: vm.tuesdaySharedPrefsSetBool(false),
              ),
              _notificationCheckListTile(
                  isNotificationEnabled: vm.isWednesdayNotificationEnabled,
                  TimeOfDayOnWeek: vm.wednesdayTimeOfDay,
                  dateTimeWeekday: vm.wednesdayDateTime,
                  stringWeekday: "水曜日",
                  notificationId: vm.wednesdayNotificationId,
                  setBoolTrue: vm.wednesdaySharedPrefsSetBool(true),
                  setBoolFalse: vm.wednesdaySharedPrefsSetBool(false)),
               _notificationCheckListTile(
                  isNotificationEnabled: vm.isThursdayNotificationEnabled, 
                  TimeOfDayOnWeek: vm.thursdayTimeOfDay, 
                  dateTimeWeekday: vm.thursdayDateTime,
                  stringWeekday: "木曜日", 
                  notificationId: vm.thursdayNotificationId, 
                  setBoolTrue: vm.thursdaySharedPrefsSetBool(true),
                  setBoolFalse: vm.thursdaySharedPrefsSetBool(false)),
              _notificationCheckListTile(
                  isNotificationEnabled: vm.isFridayNotificationEnabled,
                  TimeOfDayOnWeek: vm.fridayTimeOfDay,
                  dateTimeWeekday: vm.fridayDateTime,
                  stringWeekday: "金曜日",
                  notificationId: vm.fridayNotificationId,
                  setBoolTrue: vm.fridaySharedPrefsSetBool(true),
                  setBoolFalse: vm.fridaySharedPrefsSetBool(false)),
              _notificationCheckListTile(
                  isNotificationEnabled: vm.isSaturdayNotificationEnabled,
                  TimeOfDayOnWeek: vm.saturdayTimeOfDay,
                  dateTimeWeekday: vm.saturdayDateTime,
                  stringWeekday: "土曜日",
                  notificationId: vm.saturdayNotificationId,
                  setBoolTrue: vm.saturdaySharedPrefsSetBool(true),
                  setBoolFalse: vm.saturdaySharedPrefsSetBool(false)),
              _notificationCheckListTile(
                  isNotificationEnabled: vm.isSundayNotificationEnabled,
                  TimeOfDayOnWeek: vm.sundayTimeOfDay,
                  dateTimeWeekday: vm.sundayDateTime,
                  stringWeekday: "日曜日",
                  notificationId: vm.sundayNotificationId,
                  setBoolTrue: vm.sundaySharedPrefsSetBool(true),
                  setBoolFalse: vm.sundaySharedPrefsSetBool(false)),

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
                  ElevatedButton(
                    child: Text(
                      '毎日通知',
                    ),
                    onPressed: () async {
                      // return _everydayOnTimepicker(
                      //     context, vm.everyDayTimeOfDay);
                      return _everydayOnTimepicker();
                    },
                  ),
                  Text("vm.everyDay${vm.everyDayTimeOfDay.toString()}"),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    vm.setCancelAllNotification();
                  },
                  child: Text("全ての通知をキャンセル")),
            ]),
          ),
        );
      },
    );
  }

  // Widget _notificationCheckBoxListTile({
  //   required stringTitle,
  //   required weekdayTimeOfDay,
  //   required isNotificationEnabled,
  //   required notificationId,
  //   required WeekdayOnDateTime,
  //   required setBoolTrue,
  //   required setBoolFalse,
  // }) {
  //   final vm = context.read<FlutterLocalNotificationViewModel>();
  //   return Card(
  //       child: CheckboxListTile(
  //     //金曜
  //     title: Text(stringTitle),
  //     subtitle: _changeSubTitle(
  //       isNotificationEnabled: isNotificationEnabled,
  //       weekTimeOfDay: weekdayTimeOfDay,
  //     ),
  //     activeColor: Colors.red,
  //     checkColor: Colors.white,
  //     // secondary: Icon(Icons.face),
  //     controlAffinity: ListTileControlAffinity.leading,
  //     value: isNotificationEnabled,
  //     onChanged: (isChecked) async {
  //       vm.notificationCheckUpdate(WeekdayOnDateTime, isChecked);
  //       // vm.isTuesdayNotificationEnabled = isChecked!;
  //       // isNotificationEnabled = isChecked!; //TODO 変わらない
  //
  //       _notificationCheckBoxValue(
  //         isNotificationEnabled: isNotificationEnabled,
  //         weekTimeOfDay: weekdayTimeOfDay,
  //         stringWeekDayText: stringTitle,
  //         id: notificationId,
  //         weekdayTimeOfDay: WeekdayOnDateTime,
  //         setBoolTrue: vm.tuesdaySharedPrefsSetBool(true),
  //         setBoolFalse: vm.tuesdaySharedPrefsSetBool(false),
  //
  //         // SharedPrefsSetBool:,
  //       );
  //     },
  //   ));
  // }

  Future<void> _everydayOnTimepicker() async {
    final vm = context.read<FlutterLocalNotificationViewModel>();

    final setTime =
        await _everydayAndWeekdayCommonTimePicker(vm.everyDayTimeOfDay);
    if (setTime != null) {
      vm.changeEveryDayTimeOfDay(setTime); //謎
      vm.setEverydayNotification(
        hour: setTime.hour,
        minutes: setTime.minute,
      );
      print("weekTimeOfDay${vm.everyDayTimeOfDay}");
      // vm.changeText(weekTimeOfDay, setTime);

    }
  }

  Future<void> _weekdayOnTimepicker(
    context,
    weekdayTimeOfDay,
    id,
    WeekdayDateTime,
    stringWeekDayText,
    notificationEnabled,
  ) async {
    final BuildContext _BuildContext = context;
    final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
    final setTime = await _everydayAndWeekdayCommonTimePicker(weekdayTimeOfDay);
    if (setTime != null) {
      //setTime（タイムピッカー）で何か設定したらtrue
      // weekdayTimeOfDay = setTime; //TODO サブタイトルの時間変わらない、先生に聞いてみるべき
      vm.changeWeekdayText(WeekdayDateTime, setTime); //TODO 変わる、先生に聞いてみるべき
      vm.setWeekday(
          id, setTime.hour, setTime.minute, WeekdayDateTime, stringWeekDayText);

      vm.notificationCheckUpdate(WeekdayDateTime, true);
      // vm.isMondayNotificationEnabled = true;
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

  Future<void> _notificationCheckBox({
    required isNotificationEnabled,
    required id,
    required DateTimeTypeOnWeekDay,
    required stringWeekDayText,
    required weekTimeOfDay,
    required SharedPrefsSetBool,
  }) async {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    if (isNotificationEnabled == true) {
      //チェックがついたとき、通知ON
      // await _weekdayOnTimepicker(
      //     context, weekTimeOfDay, id, DateTimeTypeOnWeekDay, stringWeekDayText, );
      print("isNotificationEnabled:(${vm.isMondayNotificationEnabled})");
      // vm.mondaySharedPrefsSetBool(true);
      vm.setBool(weekTimeOfDay, true);
    } else {
      //チェックが外れているとき、通知OFF（キャンセル）
      await vm.setCancelNotification(
          NotificationId: id, toastMessage: stringWeekDayText);
      print("isNotificationEnabled:(${vm.isMondayNotificationEnabled})");
      // vm.mondaySharedPrefsSetBool(false);
      vm.setBool(weekTimeOfDay, false);
    }
  }

  _changeSubTitle(
      {required bool isNotificationEnabled, required TimeOfDay weekTimeOfDay}) {
    return isNotificationEnabled
        ? Text("通知する時間:${weekTimeOfDay.hour}時${weekTimeOfDay.minute}分")
        : Text("通知なし ** 時 ** 分");
  }

  void initSharePrefs() {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    vm.mondaySharedPrefsGetBool();
    vm.tuesdaySharedPrefsGetBool();
    vm.wednesdaySharedPrefsGetBool();
    vm.thursdaySharedPrefsGetBool();
    vm.fridaySharedPrefsGetBool();
    vm.saturdaySharedPrefsGetBool();
    vm.sundaySharedPrefsGetBool();
    vm.mondaySharedPrefsGetTime();
    // vm.tuesdaySharedPrefsGetTime();
    // vm.wednesdaySharedPrefsGetTime();
    // vm.thursdaySharedPrefsGetTime();
    // vm.fridaySharedPrefsGetTime();
    // vm.saturdaySharedPrefsGetTime();
    // vm.sundaySharedPrefsGetTime();
  }

  Future<void> _notificationCheckBoxValue({
    required isNotificationEnabled,
    required id,
    required weekdayTimeOfDay,
    required stringWeekDayText,
    required weekTimeOfDay,
    required setBoolTrue,
    required setBoolFalse,
    // required SharedPrefsSetBool,
  }) async {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    if (isNotificationEnabled == true) {
      //チェックがついたとき、通知ON
      await _weekdayOnTimepicker(context, weekTimeOfDay, id, weekdayTimeOfDay,
          stringWeekDayText, isNotificationEnabled);
      setBoolTrue;
      print("isNotificationEnabled:(${isNotificationEnabled})");
    } else {
      // isNotificationEnabled = false;
      //チェックが外れているとき、通知OFF（キャンセル）
      await vm.setCancelNotification(
          NotificationId: id, toastMessage: stringWeekDayText);
      setBoolFalse;
      print("isNotificationEnabled:(${isNotificationEnabled})");
    }
  }
  
  
  _notificationCheckListTile({
    required isNotificationEnabled,
    required TimeOfDayOnWeek,
    required dateTimeWeekday,
    required stringWeekday,
    required notificationId,
    required setBoolTrue,
    required setBoolFalse,
  }){
    final vm = context.read<FlutterLocalNotificationViewModel>();

    return  CustomCheckBoxListTile(
        titleText: Text(stringWeekday),
        timeSubtitle: _changeSubTitle(
          isNotificationEnabled: isNotificationEnabled,
          weekTimeOfDay: TimeOfDayOnWeek,
        ),
        isNotificationEnabled: isNotificationEnabled,
        onChanged: (isChecked) async {
          isNotificationEnabled = isChecked!; //TODO これは変わる
          vm.notificationCheckUpdate(dateTimeWeekday, isChecked);
          if (isNotificationEnabled == true) {
            //チェックがついたとき、通知ON
            await _weekdayOnTimepicker(
                context,
                TimeOfDayOnWeek,
                notificationId,
                dateTimeWeekday,
                stringWeekday,
                isNotificationEnabled);
            setBoolTrue;
            // vm.mondaySharedPrefsSetBool(true);
          } else {
            //チェックが外れているとき、通知OFF（キャンセル）
            await vm.setCancelNotification(
                NotificationId: notificationId,
                toastMessage: stringWeekday);
            // vm.mondaySharedPrefsSetBool(false);
            setBoolFalse;
          }
        }
    );
  }
 }


