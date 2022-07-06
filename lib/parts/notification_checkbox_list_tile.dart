// import 'package:flutter/material.dart';
// import 'package:local_notification/viewmodel/view_model.dart';
// import 'package:provider/provider.dart';
//
// class NotificationCheckBoxListTile extends StatelessWidget {
//   final Widget titleText;
//   final Widget timeSubtitle;
//   final ValueChanged onChanged;
//   bool isNotificationEnabled;
//
//   var timeOfDay;
//
//   var notificationId;
//
//   var weekDayOnTimeOfDay;
//
//   var stringWeekday;
//
//   var setBoolTrue;
//
//   var setBoolfalse;
//
//
//   const NotificationCheckBoxListTile({
//     required this.titleText,
//     required this.timeSubtitle,
//     required this.onChanged,
//     required this.isNotificationEnabled,
//     required this.isNotificationEnabled;
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final vm = context.read<FlutterLocalNotificationViewModel>();
//
//     return Card(
//       child: CheckboxListTile( //金曜
//           title: titleText,
//           subtitle: timeSubtitle,
//           activeColor: Colors.red,
//           checkColor: Colors.white,
//           // secondary: Icon(Icons.face),
//           controlAffinity: ListTileControlAffinity.leading,
//           value: isNotificationEnabled,
//           onChanged: (isChecked){
//                 (isChecked) async {
//               isNotificationEnabled = isChecked;
//               if (isNotificationEnabled == true) {
//                 //チェックがついたとき、通知ON
//                 await _weekdayOnTimepicker(
//                     context,
//                     timeOfDay,
//                     notificationId,
//                     weekDayOnTimeOfDay,
//                     stringWeekday,
//                     isNotificationEnabled);
//
//                 setBoolTrue;
//                 // vm.mondaySharedPrefsSetBool(true);
//               } else {
//                 //チェックが外れているとき、通知OFF（キャンセル）
//                 await vm.setCancelNotification(
//                   //TODO
//                     NotificationId: notificationId,
//                     toastMessage: stringWeekday);
//                 setBoolfalse;
//                 // vm.mondaySharedPrefsSetBool(false);
//               }
//
//             };
//           }
//       ),
//     );
//
//
//   }
//
//   Future<void> _weekdayOnTimepicker(
//       context,
//       weekdayTimeOfDay,
//       id,
//       DateTimeTypeOnWeekDay,
//       stringWeekDayText,
//       notificationEnabled,
//       // sharedPrefes,
//       ) async {
//     final BuildContext _BuildContext = context;
//     final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
//     // final initialTime = weekTimeOfDay;
//
//     final setTime = await _everydayAndWeekdayCommonTimePicker(context, weekdayTimeOfDay);
//     if (setTime != null) {
//       vm.changeWeekdayText(DateTimeTypeOnWeekDay, setTime);
//       vm.setWeekday(id, setTime.hour, setTime.minute, DateTimeTypeOnWeekDay,
//           stringWeekDayText);
//       notificationEnabled = true;
//       // vm.isMondayNotificationEnabled = true;   //setTime（タイムピッカー）で何か設定したらtrue
//
//
//     } else if (setTime == null) {
//       print("setTimenull:(${setTime})"); //TODO setTimeで判断する？
//       // vm.notificationEnabled(vm.isMondayNotificationEnabled, false);
//       // vm.isMondayNotificationEnabled = false;  //setTime（タイムピッカー）で何も設定しなかったたらFalse
//       notificationEnabled = false;
//
//       // vm.notificationEnabled(false);
//     }
//   }
//
//   Future<TimeOfDay?> _everydayAndWeekdayCommonTimePicker(context, time) async {
//     return await showTimePicker(
//       context: context,
//       initialTime: time,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "通知する時間を設定してください",
//       cancelText: "キャンセル",
//       confirmText: "決定",
//     );
//   }
// }
