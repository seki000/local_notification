import 'package:flutter/material.dart';

class CustomCheckBoxListTile extends StatelessWidget {
  final Widget titleText;
  final Widget timeSubtitle;
  final ValueChanged onChanged;
  final bool isNotificationEnabled;


  const CustomCheckBoxListTile({
    required this.titleText,
    required this.timeSubtitle,
    required this.onChanged,
    required this.isNotificationEnabled,
});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile( //金曜
        title: titleText,
        subtitle: timeSubtitle,
        activeColor: Colors.red,
        checkColor: Colors.white,
        // secondary: Icon(Icons.face),
        controlAffinity: ListTileControlAffinity.leading,
        value: isNotificationEnabled,
        onChanged: onChanged
        ),
    );
  }
}
