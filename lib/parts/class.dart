





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/view_model.dart';

class NotificationCheck extends StatelessWidget{
  // Widget timeSubtitle;
  // ValueChanged onChanged;
  bool isNotificationEnabled;
  TimeOfDay timeOfDay;
  int notificationId;
  var DateTimeWeekday;
  String stringWeekday;
  var setBoolTrue;
  var setBoolFalse;

  NotificationCheck(
      this.stringWeekday,
      // this.timeSubtitle,
      // this.onChanged,
  this.isNotificationEnabled,
  this.timeOfDay,
  this.notificationId,
  this.DateTimeWeekday,
  this.setBoolTrue,
  this.setBoolFalse,


      );

  @override
  Widget build(BuildContext context) {
    final vm = context.read<FlutterLocalNotificationViewModel>();

    return Card(
      child: CheckboxListTile(
          //金曜
          title: Text(stringWeekday),
          subtitle: _changeSubTitle(isNotificationEnabled: isNotificationEnabled, weekTimeOfDay: timeOfDay),
          // subtitle: timeSubtitle,
          activeColor: Colors.red,
          checkColor: Colors.white,
          // secondary: Icon(Icons.face),
          controlAffinity: ListTileControlAffinity.leading,
          value: isNotificationEnabled,
          onChanged: (isChecked) {
            (isChecked) async {
              isNotificationEnabled = isChecked!;
              if (isNotificationEnabled == true) {
                //チェックがついたとき、通知ON
                await _weekdayOnTimepicker(context, timeOfDay, notificationId,
                    DateTimeWeekday, stringWeekday, isNotificationEnabled);

                setBoolTrue;
                // vm.mondaySharedPrefsSetBool(true);
              } else {
                //チェックが外れているとき、通知OFF（キャンセル）
                await vm.setCancelNotification(
                    //TODO
                    NotificationId: notificationId,
                    toastMessage: stringWeekday);
                setBoolFalse;
                // vm.mondaySharedPrefsSetBool(false);
              }
            };
          }),
    );
  }

  Future<void> _weekdayOnTimepicker(
    context,
    weekdayTimeOfDay,
    id,
    weekday,
    stringWeekDayText,
    notificationEnabled,
    // sharedPrefes,
  ) async {
    final BuildContext _BuildContext = context;
    final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
    // final initialTime = weekTimeOfDay;

    final setTime =
        await _everydayAndWeekdayCommonTimePicker(context, weekdayTimeOfDay);
    if (setTime != null) {
      vm.changeWeekdayText(weekday, setTime);
      vm.setWeekday(id, setTime.hour, setTime.minute, weekday,
          stringWeekDayText);
      notificationEnabled = true;
      // vm.isMondayNotificationEnabled = true;   //setTime（タイムピッカー）で何か設定したらtrue

    } else if (setTime == null) {
      print("setTimenull:(${setTime})"); //TODO setTimeで判断する？
      // vm.notificationEnabled(vm.isMondayNotificationEnabled, false);
      // vm.isMondayNotificationEnabled = false;  //setTime（タイムピッカー）で何も設定しなかったたらFalse
      notificationEnabled = false;

      // vm.notificationEnabled(false);
    }
  }

  Future<TimeOfDay?> _everydayAndWeekdayCommonTimePicker(context, time) async {
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
        : Text("通知なし ** 時 ** 分");
  }
}
