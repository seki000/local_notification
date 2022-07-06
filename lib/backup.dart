// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:local_notification/viewmodel/view_model.dart';
// import 'package:provider/provider.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     final vm = context.read<FlutterLocalNotificationViewModel>();
//     vm.initTimeAndNotification(context);
//     vm.requestPermissionsOnIos();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, vm, child) {
//         final vm = context.watch<FlutterLocalNotificationViewModel>();
//
//         return Scaffold(
//           body: Column(mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "月曜日に通知",
//                       ),
//                       onPressed: () async {
//                         _weekdayOnTimepicker(context, vm.mondayTimeOfDay,
//                             vm.mondayNotificationId, DateTime.monday, "月曜日");
//                         // vm.setMondayNotification(context: context);
//                         // vm.setWeekdayNotification(
//                         //     context: context,
//                         //     id: vm.mondayNotificationId,
//                         //     DateTimeTypeOnWeekDay: DateTime.monday,
//                         //     stringWeekDay: "月曜日",
//                         //     weekTimeOfDay: vm.mondayTimeOfDay);
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                             NotificationId: vm.mondayNotificationId,
//                             toastMessage: "月曜日",
//                           );
//                         },
//                         child: Text("月曜日通知キャンセル")
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "火曜日に通知",
//                       ),
//                       onPressed: () async {
//                         _weekdayOnTimepicker(context, vm.tuesdayTimeOfDay,
//                             vm.tuesdayNotificationId, DateTime.tuesday, "火曜日");
//                         // vm.setTuesdayNotification(context: context);
//                         // vm.weekdayNotification(
//                         //     context: context,
//                         //     id: vm.tuesdayNotificationId,
//                         //     DateTimeTypeOnWeekDay: DateTime.tuesday,
//                         //     stringWeekDay: "火曜日",
//                         //     weekTimeOfDay: vm.tuesdayTimeOfDay);
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                             NotificationId: vm.tuesdayNotificationId,
//                             toastMessage: "火曜日",
//                           );
//                         },
//                         child: Text("火曜日通知キャンセル")),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "水曜日に通知",
//                       ),
//                       onPressed: () async {
//                         _weekdayOnTimepicker(context, vm.wednesdayTimeOfDay,
//                             vm.wednesdayNotificationId, DateTime.wednesday, "水曜日");
//                         // vm.setWednesdayNotification(context: context);
//                         // vm.setWeekdayNotification(
//                         //     context: context,
//                         //     id: vm.wednesdayNotificationId,
//                         //     DateTimeTypeOnWeekDay: DateTime.wednesday,
//                         //     stringWeekDay: "水曜日",
//                         //     weekTimeOfDay: vm.wednesdayTimeOfDay);
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                             NotificationId: vm.wednesdayNotificationId,
//                             toastMessage: "水曜日",
//                           );
//                         },
//                         child: Text("水曜日通知キャンセル")),
//
//                   ],
//                 ),
//                 // Text("通知する時間：${wednesday.hour}" +
//                 //     "時" +
//                 //     "${wednesday.minute}" +
//                 //     "分"),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "木曜日に通知",
//                       ),
//                       onPressed: () async {
//                         _weekdayOnTimepicker(context, vm.thursdayTimeOfDay,
//                             vm.thursdayNotificationId, DateTime.thursday, "土曜日");
//                         // vm.setThursdayNotification(context: context);
//                         // vm.setWeekdayNotification(
//                         //     context: context,
//                         //     id: vm.thursdayNotificationId,
//                         //     DateTimeTypeOnWeekDay: DateTime.thursday,
//                         //     stringWeekDay: "木曜日",
//                         //     weekTimeOfDay: vm.thursdayTimeOfDay);
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                             NotificationId: vm.thursdayNotificationId,
//                             toastMessage: "木曜日",
//                           );
//                         },
//                         child: Text("木曜日通知キャンセル")),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "金曜日に通知",
//                       ),
//                       onPressed: () async {
//                         _weekdayOnTimepicker(context, vm.fridayTimeOfDay,
//                             vm.fridayNotificationId, DateTime.friday, "金曜日");
//                         // vm.setFridayNotification(context: context);
//                         // vm.setWeekdayNotification(
//                         //     context: context,
//                         //     id: vm.fridayNotificationId,
//                         //     DateTimeTypeOnWeekDay: DateTime.friday,
//                         //     stringWeekDayText: "金曜日",
//                         //     weekTimeOfDay: vm.fridayTimeOfDay);
//                         // timePickerForWeekly(vm.fridayNotificationId,
//                         //     DateTime.friday, "金曜日", vm.fridayTimeOfDay);
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                             NotificationId: vm.fridayNotificationId,
//                             toastMessage: "金曜日",
//                           );
//                         },
//                         child: Text("金曜日通知キャンセル")),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                         child: Text(
//                           "土曜日に通知",
//                         ),
//                         onPressed: () async {
//                           _weekdayOnTimepicker(context, vm.saturdayTimeOfDay,
//                               vm.saturdayNotificationId, DateTime.saturday, "土曜日");
//                           // vm.setSaturdayNotification(context: context);
//                           // vm.setWeekdayNotification(
//                           //     context: context,
//                           //     id: vm.saturdayNotificationId,
//                           //     DateTimeTypeOnWeekDay: DateTime.saturday,
//                           //     stringWeekDay: "土曜日",
//                           //     weekTimeOfDay: vm.saturdayTimeOfDay);
//                         }),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                             NotificationId: vm.saturdayNotificationId,
//                             toastMessage: "土曜日",
//                           );
//                         },
//                         child: Text("土曜日通知キャンセル")),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "日曜日に通知",
//                       ),
//                       onPressed: () async {
//                         _weekdayOnTimepicker(context, vm.sundayTimeOfDay,
//                             vm.sundayNotificationId, DateTime.sunday, "日曜日");
//                         // vm.setSundayNotification(context: context);
//                         // vm.setWeekdayNotification(
//                         //     context: context,
//                         //     id: vm.sundayNotificationId,
//                         //     DateTimeTypeOnWeekDay: DateTime.sunday,
//                         //     stringWeekDay: "日曜日",
//                         //     weekTimeOfDay: vm.sundayTimeOfDay);
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                             NotificationId: vm.sundayNotificationId,
//                             toastMessage: "日曜日",
//                           );
//                         },
//                         child: Text("日曜日通知キャンセル")),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "1分ごとにリピート通知",
//                       ),
//                       onPressed: () async {
//                         vm.setRepeatOneMinutesNotification();
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           vm.setCancelNotification(
//                               NotificationId: vm.repeatOneMinutesNotificationId,
//                               toastMessage: "リピート");
//                         },
//                         child: Text("リピート通知キャンセル")),
//                   ],
//                 ),
//                 Center(
//                   child: ElevatedButton(
//                       onPressed: () async {
//                         await vm.setNowNotification();
//                       },
//                       child: Text("すぐに通知")
//                   ),
//                 ),
//                 Center(
//                   child: ElevatedButton(
//                       onPressed: () async {
//                         // await threeSecondsNotification();
//                         await vm.setThreeSecondsNotification(
//                             context: context);
//                       },
//                       child: Text("3秒後に通知(色々実験)")),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         '毎日通知',
//                       ),
//                       onPressed: () async {
//                         return _everydayOnTimepicker(
//                             context, vm.everyDayTimeOfDay);
//                         // vm.everydayNotification(
//                         //   context: context,
//                         //   id: vm.everyDayNotificationId
//                         // );
//                       },
//                     ),
//                     Text("vm.everyDay${vm.everyDayTimeOfDay.toString()}"),
//                   ],
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       vm.setCancelAllNotification();
//                     },
//                     child: Text("全ての通知をキャンセル")),
//               ]),
//         );
//       },
//     );
//   }
//
//   Future<void> _everydayOnTimepicker(context,
//       viewModelsEverydayTimeOfDay) async {
//     final BuildContext _BuildContext = context;
//     final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
//     // final initialTime = weekTimeOfDay;
//
//     final setTime =
//     // await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
//     await _everydayAndWeekdayCommonTimePicker(viewModelsEverydayTimeOfDay);
//     if (setTime != null) {
//       // viewModelsEverydayTimeOfDay = setTime;
//       vm.changeEveryDayTimeOfDay(viewModelsEverydayTimeOfDay, setTime);
//       vm.setEverydayNotification(hour: setTime.hour, minutes: setTime.minute,);
//       print("weekTimeOfDay$viewModelsEverydayTimeOfDay");
//       // vm.changeText(weekTimeOfDay, setTime);
//
//     }
//   }
//
//   Future<void> _weekdayOnTimepicker(context, weekdayTimeOfDay, id,
//       DateTimeTypeOnWeekDay, stringWeekDayText,) async {
//     final BuildContext _BuildContext = context;
//     final vm = _BuildContext.read<FlutterLocalNotificationViewModel>();
//     // final initialTime = weekTimeOfDay;
//
//     final setTime = await _everydayAndWeekdayCommonTimePicker(weekdayTimeOfDay);
//     if (setTime != null) {
//       // viewModelsEverydayTimeOfDay = setTime;
//       // vm.changeEveryDayTimeOfDay(weekdayTimeOfDay, setTime); //TODO
//       vm.setWeekday( id, setTime.hour, setTime.minute,  DateTimeTypeOnWeekDay, stringWeekDayText);
//
//     }
//   }
//
//   Future<TimeOfDay?>  _everydayAndWeekdayCommonTimePicker(time) async{
//     return  await showTimePicker(
//       context: context,
//       initialTime: time,
//       initialEntryMode: TimePickerEntryMode.dial,
//       helpText: "通知する時間を設定してください",
//       cancelText: "キャンセル",
//       confirmText: "決定",
//     );
//   }
//
//
// // Future<void> _weekDayOnTimepicker(context, weekTimeOfDay) async{
// //   final initialTime = weekTimeOfDay;
// //   final setTime =
// //   await _everydayAndWeekdayCommonShowTimepicker(context, initialTime);
// //   if (setTime != null) {
// //     weekTimeOfDay = setTime;
// //   }
// // }
//
// //
// // Future<TimeOfDay?> _everydayAndWeekdayCommonShowTimepicker(BuildContext context, initialTime) async{
// //    await showTimePicker(
// //   context: context,
// //   initialTime: initialTime,
// //   initialEntryMode: TimePickerEntryMode.dial,
// //   helpText: "通知する時間を設定してください",
// //   cancelText: "キャンセル",
// //   confirmText: "決定",
// //   );
// // }
// }
