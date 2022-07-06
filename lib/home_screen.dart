import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification/model/shared_prefs.dart';
import 'package:local_notification/parts/class.dart';
import 'package:local_notification/parts/custom_checkboxListTile.dart';
import 'package:local_notification/viewmodel/view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTuesdayNotificationEnabled = false;




  @override
  void initState() {
    super.initState();
    final vm = context.read<FlutterLocalNotificationViewModel>();
    vm.initTimeAndNotification(context);
    vm.requestPermissionsOnIos();
    initSharePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, vm, child) {
        final vm = context.watch<FlutterLocalNotificationViewModel>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              CustomCheckBoxListTile(
                  titleText: Text("月曜日に通知"),
                  timeSubtitle: _changeSubTitle(
                    isNotificationEnabled: vm.isMondayNotificationEnabled,
                    weekTimeOfDay: vm.mondayTimeOfDay,
                  ),
                  isNotificationEnabled: vm.isMondayNotificationEnabled,
                  onChanged: (isChecked) async {
                    vm.isMondayNotificationEnabled = isChecked!; //TODO これは変わる
                    if (vm.isMondayNotificationEnabled == true) {
                      //チェックがついたとき、通知ON
                      await _weekdayOnTimepicker(
                          context,
                          vm.mondayTimeOfDay,
                          vm.mondayNotificationId,
                          DateTime.monday,
                          "月曜日",
                          vm.isMondayNotificationEnabled);
                      vm.mondaySharedPrefsSetBool(true);
                    } else {
                      //チェックが外れているとき、通知OFF（キャンセル）
                      await vm.setCancelNotification(
                          NotificationId: vm.mondayNotificationId,
                          toastMessage: "月曜日");
                      vm.mondaySharedPrefsSetBool(false);
                    }
                  }
              ),
               _notificationCheckBoxListTile(
                  stringTitle: "火曜日",
                  weekdayTimeOfDay: vm.tuesdayTimeOfDay,
                  isNotificationEnabled: vm.isTuesdayNotificationEnabled,
                  notificationId: vm.tuesdayNotificationId,
                  WeekdayOnDateTime: vm.tuesdayDateTime, 
                   setBoolTrue: vm.tuesdaySharedPrefsSetBool(true),
                   setBoolFalse: vm.tuesdaySharedPrefsSetBool(false)),
              CustomCheckBoxListTile(
                  titleText: Text("水曜日"),
                  timeSubtitle: _changeSubTitle(
                    isNotificationEnabled: vm.isWednesdayNotificationEnabled,
                    weekTimeOfDay: vm.wednesdayTimeOfDay,
                  ),
                  isNotificationEnabled: vm.isWednesdayNotificationEnabled,
                  onChanged: (isChecked) async {
                    vm.isWednesdayNotificationEnabled = isChecked!; //TODO これは変わる
                    if (vm.isWednesdayNotificationEnabled == true) {
                      //チェックがついたとき、通知ON
                      await _weekdayOnTimepicker(
                          context,
                          vm.wednesdayTimeOfDay,
                          vm.wednesdayNotificationId,
                          DateTime.wednesday,
                          "水曜日",
                          vm.isWednesdayNotificationEnabled);
                      vm.wednesdaySharedPrefsSetBool(true);
                    } else {
                      //チェックが外れているとき、通知OFF（キャンセル）
                      await vm.setCancelNotification(
                          NotificationId: vm.wednesdayNotificationId,
                          toastMessage: "水曜日");
                      vm.wednesdaySharedPrefsSetBool(false);
                    }
                  }
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
                  ElevatedButton(
                    child: Text(
                      '毎日通知',
                    ),
                    onPressed: () async {
                      return _everydayOnTimepicker(
                          context, vm.everyDayTimeOfDay);
                      // vm.everydayNotification(
                      //   context: context,
                      //   id: vm.everyDayNotificationId
                      // );
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

  Widget _notificationCheckBoxListTile({
    required stringTitle,
    required weekdayTimeOfDay,
    required isNotificationEnabled,
    required notificationId,
    required WeekdayOnDateTime,
    required setBoolTrue,
    required setBoolFalse,
  }) {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    return Card(
        child: CheckboxListTile( //金曜
          title: Text(stringTitle),
          subtitle: _changeSubTitle(
            isNotificationEnabled: isNotificationEnabled,
            weekTimeOfDay: weekdayTimeOfDay,
          ),
          activeColor: Colors.red,
          checkColor: Colors.white,
          // secondary: Icon(Icons.face),
          controlAffinity: ListTileControlAffinity.leading,
          value: isNotificationEnabled,
          onChanged: (isChecked) async{
            vm.notificationCheckUpdate(WeekdayOnDateTime, isChecked);
            // vm.isTuesdayNotificationEnabled = isChecked!;
            // isNotificationEnabled = isChecked!; //TODO 変わらない

            _notificationCheckBoxValue(
              isNotificationEnabled: isNotificationEnabled,
              weekTimeOfDay: weekdayTimeOfDay,
              stringWeekDayText: stringTitle,
              id: notificationId,
              weekdayTimeOfDay: WeekdayOnDateTime,
              setBoolTrue: vm.tuesdaySharedPrefsSetBool(true),
              setBoolFalse: vm.tuesdaySharedPrefsSetBool(false),

              // SharedPrefsSetBool:,
            );
          },
        ));
  }


  Future<void> _everydayOnTimepicker(context,
      viewModelsEverydayTimeOfDay) async {
    final BuildContext _BuildContext = context;
    final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
    // final initialTime = weekTimeOfDay;

    final setTime =
    // await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
    await _everydayAndWeekdayCommonTimePicker(viewModelsEverydayTimeOfDay);
    if (setTime != null) {
      // viewModelsEverydayTimeOfDay = setTime;
      vm.changeEveryDayTimeOfDay(viewModelsEverydayTimeOfDay, setTime); //謎
      vm.setEverydayNotification(
        hour: setTime.hour,
        minutes: setTime.minute,
      );
      print("weekTimeOfDay$viewModelsEverydayTimeOfDay");
      // vm.changeText(weekTimeOfDay, setTime);

    }
  }

  Future<void> _weekdayOnTimepicker(context,
      weekdayTimeOfDay,
      id,
      WeekdayDateTime,
      stringWeekDayText,
      notificationEnabled,) async {
    final BuildContext _BuildContext = context;
    final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
    final setTime = await _everydayAndWeekdayCommonTimePicker(weekdayTimeOfDay);
    if (setTime != null) {    //setTime（タイムピッカー）で何か設定したらtrue
      // weekdayTimeOfDay = setTime; //TODO サブタイトルの時間変わらない、先生に聞いてみるべき
      vm.changeWeekdayText(WeekdayDateTime, setTime); //TODO 変わる、先生に聞いてみるべき
      vm.setWeekday(id, setTime.hour, setTime.minute, WeekdayDateTime,
          stringWeekDayText);

      vm.notificationCheckUpdate(WeekdayDateTime, true);
      // vm.isMondayNotificationEnabled = true;
    } else if (setTime == null) {     //setTime（タイムピッカー）で何も設定しなかったたらFalse
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
          NotificationId: id,
          toastMessage: stringWeekDayText);
      print("isNotificationEnabled:(${vm.isMondayNotificationEnabled})");
      // vm.mondaySharedPrefsSetBool(false);
      vm.setBool(weekTimeOfDay, false);
    }

    // if(isNotificationEnabled == vm.isMondayNotificationEnabled){
    //   vm.mondaySharedPrefsSetBool(isNotificationEnabled);
    // }else if(isNotificationEnabled == vm.isTuesdayNotificationEnabled){
    //   vm.tuesdaySharedPrefsSetBool(isNotificationEnabled);
    // }else if(isNotificationEnabled == vm.isWednesdayNotificationEnabled){
    //   vm.wednesdaySharedPrefsSetBool(isNotificationEnabled);
    // }else if(isNotificationEnabled == vm.isThursdayNotificationEnabled){
    //   vm.thursdaySharedPrefsSetBool(isNotificationEnabled);
    // }else if(isNotificationEnabled == vm.isFridayNotificationEnabled){
    //   vm.fridaySharedPrefsSetBool(isNotificationEnabled);
    // }else if(isNotificationEnabled == vm.isSaturdayNotificationEnabled){
    //   vm.saturdaySharedPrefsSetBool(isNotificationEnabled);
    // }else if(isNotificationEnabled == vm.isSundayNotificationEnabled){
    //   vm.sundaySharedPrefsSetBool(isNotificationEnabled);
    // }
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
    vm.tuesdaySharedPrefsGetTime();
    vm.wednesdaySharedPrefsGetTime();
    vm.thursdaySharedPrefsGetTime();
    vm.fridaySharedPrefsGetTime();
    vm.saturdaySharedPrefsGetTime();
    vm.sundaySharedPrefsGetTime();
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
      await _weekdayOnTimepicker(
          context, weekTimeOfDay, id, weekdayTimeOfDay, stringWeekDayText, isNotificationEnabled);
      setBoolTrue;
      print("isNotificationEnabled:(${isNotificationEnabled})");
    } else {
      // isNotificationEnabled = false;
      //チェックが外れているとき、通知OFF（キャンセル）
      await vm.setCancelNotification(
          NotificationId: id,
          toastMessage: stringWeekDayText);
      setBoolFalse;
      print("isNotificationEnabled:(${isNotificationEnabled})");

    }
  }



//   _notificationListTile({
//     required context,
//     required stringText,
//     required NotificationEnabled,
//     required weekTimeOfDay,
//     required id,
//     required weekdayDateTime
// }) {
//     final BuildContext _BuildContext = context;
//     final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
//   return  CustomCheckBoxListTile(
//         titleText: Text(stringText),
//         timeSubtitle: _changeSubTitle(
//           isNotificationEnabled: NotificationEnabled,
//           weekTimeOfDay: weekTimeOfDay,
//         ),
//         isNotificationEnabled: NotificationEnabled,
//         onChanged: (isChecked) async {
//           NotificationEnabled = isChecked;
//           if (NotificationEnabled == true) {
//             //チェックがついたとき、通知ON
//             await _weekdayOnTimepicker(
//                 context,
//                 weekTimeOfDay,
//                 id,
//                 weekdayDateTime,
//                 stringText,
//                 NotificationEnabled);
//             // vm.mondaySharedPrefsSetBool(true);
//             vm.setBool(weekdayDateTime, true);
//           } else {
//             //チェックが外れているとき、通知OFF（キャンセル）
//             await vm.setCancelNotification(
//                 NotificationId: vm.mondayNotificationId,
//                 toastMessage: stringText);
//             vm.setBool(weekdayDateTime, false);
//             // vm.mondaySharedPrefsSetBool(false);
//           }
//         }
//     );
//   }
}
