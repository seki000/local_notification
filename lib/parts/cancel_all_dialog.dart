import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/view_model.dart';

class CancelAllDialog extends StatelessWidget {
  const CancelAllDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
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
