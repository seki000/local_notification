import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:local_notification/parts/cancel_all_dialog.dart';
import 'package:local_notification/parts/custom_checkbox_listtile.dart';
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
  }

  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: Consumer<FlutterLocalNotificationViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isMondayNotificationEnabled,
                  weekOrEverydayTime: vm.mondayDateTime,
                  weekday: DateTime.monday,
                  stringMessageText: "月曜日",
                  notificationId: vm.mondayNotificationId,
                  enumType: NotificationType.WEEKDAY,
                ),
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isTuesdayNotificationEnabled,
                  weekOrEverydayTime: vm.tuesdayDateTime,
                  weekday: DateTime.tuesday,
                  stringMessageText: "火曜日",
                  notificationId: vm.tuesdayNotificationId,
                  enumType: NotificationType.WEEKDAY,
                ),
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isWednesdayNotificationEnabled,
                  weekOrEverydayTime: vm.wednesdayDateTime,
                  weekday: DateTime.wednesday,
                  stringMessageText: "水曜日",
                  notificationId: vm.wednesdayNotificationId,
                  enumType: NotificationType.WEEKDAY,
                ),
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isThursdayNotificationEnabled,
                  weekOrEverydayTime: vm.thursdayDateTime,
                  weekday: DateTime.thursday,
                  stringMessageText: "木曜日",
                  notificationId: vm.thursdayNotificationId,
                  enumType: NotificationType.WEEKDAY,
                ),
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isFridayNotificationEnabled,
                  weekOrEverydayTime: vm.fridayDateTime,
                  weekday: DateTime.friday,
                  stringMessageText: "金曜日",
                  notificationId: vm.fridayNotificationId,
                  enumType: NotificationType.WEEKDAY,
                ),
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isSaturdayNotificationEnabled,
                  weekOrEverydayTime: vm.saturdayDateTime,
                  weekday: DateTime.saturday,
                  stringMessageText: "土曜日",
                  notificationId: vm.saturdayNotificationId,
                  enumType: NotificationType.WEEKDAY,
                ),
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isSundayNotificationEnabled,
                  weekOrEverydayTime: vm.sundayDateTime,
                  weekday: DateTime.sunday,
                  stringMessageText: "日曜日",
                  notificationId: vm.sundayNotificationId,
                  enumType: NotificationType.WEEKDAY,
                ),
                _notificationCheckListTile(
                  isNotificationEnabled: vm.isEveryDayNotificationEnabled,
                  weekOrEverydayTime: vm.everyDayDateTime,
                  //毎日通知は曜日いらない
                  stringMessageText: "毎日",
                  notificationId: vm.everyDayNotificationId,
                  enumType: NotificationType.EVERYDAY,
                ),
                CheckboxListTile(
                    title: Text("リピート通知(１分毎)"),
                    value: vm.isRepeatOneMinutesNotificationEnabled,
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    secondary: Icon(
                      Icons.repeat,
                      color: vm.isRepeatOneMinutesNotificationEnabled ? Colors.red : Colors.grey,
                    ),
                    onChanged: (isChecked) {
                      vm.isRepeatOneMinutesNotificationEnabled = isChecked!;
                      if (vm.isRepeatOneMinutesNotificationEnabled == true) {
                        vm.setRepeatOneMinutesNotification();
                      } else {
                        vm.setCancelNotification(
                            NotificationId: vm.repeatOneMinutesNotificationId,
                            toastMessage: "リピート");
                      }
                      vm.repeatNotificationCheckUpdate(isChecked);
                    }),
                ListTile(
                  title: Text("全ての通知をキャンセルする"),
                  leading: Icon(Icons.cancel_outlined),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => CancelAllDialog());
                  },
                ),
                ListTile(
                  title: Text("すぐに通知"),
                  onTap: () async {
                    await vm.setNowNotification();
                  },
                ),
                ListTile(
                  title: Text("３秒後に通知"),
                  onTap: () async {
                    // await threeSecondsNotification();
                    await vm.setThreeSecondsNotification(context: context);
                  },
                ),

              ]),
            ),
          );
        },
      ),
    );
  }

  Future<void> _everydayOnTimepicker({
    required weekdayTime,
    required id,
    required stringWeekDayText,
    required notificationEnabled,
  }) async {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    DatePicker.showTimePicker(
      context,
      locale: LocaleType.jp,
      showSecondsColumn: false, //trueで秒まで表示
      onCancel: () {
        vm.notificationCheckUpdate(null, false);
      },
      onConfirm: (selectedTime) {
        vm.changeWeekdayTime(null, selectedTime);
        vm.setEverydayNotification(
            id: id,
            hour: selectedTime.hour,
            minutes: selectedTime.minute,
            toastText: stringWeekDayText);
      },
    );
  }

  Future<void> _weekdayOnTimepicker({
    required weekdayTime,
    required id,
    required weekday,
    required stringWeekDayText,
  }) async {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    DatePicker.showTimePicker(
      context,
      locale: LocaleType.jp,
      showSecondsColumn: false, //trueで秒まで表示
      onCancel: () {
        vm.notificationCheckUpdate(weekday, false);
      },
      onConfirm: (selectedTime) {
        vm.changeWeekdayTime(weekday, selectedTime);
        vm.setWeekday(id, selectedTime.hour, selectedTime.minute, weekday,
            stringWeekDayText);
        vm.notificationCheckUpdate(weekday, true);
      },
    );
  }

  Widget _notificationCheckListTile({
    required isNotificationEnabled,
    required weekOrEverydayTime,
    weekday, //曜日は毎日通知だといらないので曜日指定の時だけ入れる
    required stringMessageText,
    required notificationId,
    required enumType,
  }) {
    final vm = context.read<FlutterLocalNotificationViewModel>();
    return  CustomCheckboxListTile(
        stringMessageText: stringMessageText,
        isNotificationEnabled: isNotificationEnabled,
        weekOrEverydayTime: weekOrEverydayTime,
        onChanged: (isChecked) async {
          isNotificationEnabled = isChecked!;
          vm.notificationCheckUpdate(weekday, isChecked);
          if (enumType == NotificationType.EVERYDAY) {
            if (isNotificationEnabled == true) {
              //チェックがついたとき、通知ON
              await _everydayOnTimepicker(
                  weekdayTime: weekOrEverydayTime,
                  id: notificationId,
                  stringWeekDayText: stringMessageText,
                  notificationEnabled: isNotificationEnabled);
            } else if (isNotificationEnabled == false) {
              //チェックが外れているとき、通知OFF（キャンセル）
              await vm.setCancelNotification(
                  NotificationId: notificationId,
                  toastMessage: stringMessageText);
            }
          } else if (enumType == NotificationType.WEEKDAY) {
            if (isNotificationEnabled == true) {
              //チェックがついたとき、通知ON
              await _weekdayOnTimepicker(
                weekdayTime: weekOrEverydayTime,
                id: notificationId,
                weekday: weekday,
                stringWeekDayText: stringMessageText,
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
}
