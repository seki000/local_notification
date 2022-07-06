import 'package:flutter/material.dart';
import 'package:local_notification/model/notification_repository.dart';
import 'package:local_notification/viewmodel/view_model.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'model/shared_prefs.dart';


void main() async {
  runApp(
    MultiProvider(providers: [
      Provider<SharedPrefsManager>(
        create: (_) => SharedPrefsManager(),
      ),
    ChangeNotifierProvider<FlutterLocalNotificationViewModel>(
    create: (context) =>
      FlutterLocalNotificationViewModel(flutterLocalNotificationRepository: FlutterLocalNotificationRepository()),
    ),


    ],
        child: MyApp()

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '通知',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child:  HomeScreen()),
    );
  }
}



