import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final String stringMessageText;

  final bool isNotificationEnabled;

  final DateTime weekOrEverydayTime;

  final ValueChanged onChanged;

  const CustomCheckboxListTile({
    required this.stringMessageText,
    required this.isNotificationEnabled,
    required this.weekOrEverydayTime,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(stringMessageText),
        subtitle: _changeSubTitle(
          isNotificationEnabled: isNotificationEnabled,
          weekTime: weekOrEverydayTime,
        ),
        activeColor: Colors.red,
        checkColor: Colors.white,
        secondary: Icon(
          Icons.notifications,
          color: isNotificationEnabled ? Colors.red : Colors.grey,
          // color: Colors.red,
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        value: isNotificationEnabled,
        onChanged: onChanged
        );
  }

_changeSubTitle(
    {required bool isNotificationEnabled, required DateTime weekTime}) {
  return isNotificationEnabled
      ? Text("通知する時間:${weekTime.hour}時${weekTime.minute}分")
      : Text("通知なし");
}}

