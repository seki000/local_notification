
import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY_NOTIFICATION_MONDAY_TIME = "monday_time_id";
const PREF_KEY_NOTIFICATION_TUESDAY_TIME = "tuesday_time_id";
const PREF_KEY_NOTIFICATION_WEDNESDAY_TIME = "wednesday_time_id";
const PREF_KEY_NOTIFICATION_THURSDAY_TIME = "thursday_time_id";
const PREF_KEY_NOTIFICATION_FRIDAY_TIME = "friday_time_id";
const PREF_KEY_NOTIFICATION_SATURDAY_TIME = "saturday_time_id";
const PREF_KEY_NOTIFICATION_SUNDAY_TIME = "sunday_time_id";
const PREF_KEY_NOTIFICATION_EVERYDAY_TIME = "everyday_time_id";

const PREF_KEY_NOTIFICATION_MONDAY_CHECK = "monday_check_id";
const PREF_KEY_NOTIFICATION_TUESDAY_CHECK = "tuesday_check_id";
const PREF_KEY_NOTIFICATION_WEDNESDAY_CHECK = "wednesday_check_id";
const PREF_KEY_NOTIFICATION_THURSDAY_CHECK = "thursday_check_id";
const PREF_KEY_NOTIFICATION_FRIDAY_CHECK = "friday_check_id";
const PREF_KEY_NOTIFICATION_SATURDAY_CHECK = "saturday_check_id";
const PREF_KEY_NOTIFICATION_SUNDAY_CHECK = "sunday_check_id";
const PREF_KEY_NOTIFICATION_EVERYDAY_CHECK = "everyday_check_id";



class SharedPrefsManager {

  //曜日ごとのチェックボックスの値の保存と読み込み
  Future<bool> getBoolOnMonday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("getBoolOnMonday");
    return await prefs.getBool(PREF_KEY_NOTIFICATION_MONDAY_CHECK)  ?? false;
  }

  Future<bool> setBoolOnMonday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("setBoolOnMonday");
    return await prefs.setBool(PREF_KEY_NOTIFICATION_MONDAY_CHECK, isChecked);
    // return await prefs.setBool(PREF_KEY_NOTIFICATION_MONDAY_CHECK, isChecked);
  }

  Future<bool> getBoolOnTuesday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_TUESDAY_CHECK)  ?? false;
  }

  Future<bool> setBoolOnTuesday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_TUESDAY_CHECK, isChecked);
  }

  Future<bool> getBoolOnWednesday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_WEDNESDAY_CHECK)  ?? false;
  }

  Future<bool> setBoolOnWednesday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_WEDNESDAY_CHECK, isChecked);
  }

  Future<bool> getBoolOnThursday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_THURSDAY_CHECK)  ?? false;
  }

  Future<bool> setBoolOnThursday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_THURSDAY_CHECK, isChecked);
  }

  Future<bool> getBoolOnFriday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_FRIDAY_CHECK)  ?? false;
  }

  Future<bool> setBoolOnFriday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_FRIDAY_CHECK, isChecked);
  }

  Future<bool> getBoolOnSaturday() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     return await prefs.getBool(PREF_KEY_NOTIFICATION_SATURDAY_CHECK)  ?? false;
  }

  Future<bool> setBoolOnSaturday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_SATURDAY_CHECK, isChecked);
  }

  Future<bool> getBoolOnSunday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_SUNDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnEveryday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_EVERYDAY_CHECK)  ?? false;
  }

  Future<bool> setBoolOnSunday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_SUNDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnEveryday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_EVERYDAY_CHECK, isChecked);
  }



  //曜日ごとのTimeOfDay保存と読み込み
  Future<String> getTimeOnMonday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_MONDAY_TIME) ?? DateTime.now().toString() ;
    // return await prefs.getString(PREF_KEY_NOTIFICATION_MONDAY_TIME) ?? DateTime.now().toString() ;
  }

  Future<String> getTimeOnTuesday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_TUESDAY_TIME) ?? DateTime.now().toString() ;
  }

  Future<String> getTimeOnWednesday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_WEDNESDAY_TIME) ?? DateTime.now().toString() ;
  }

  Future<String> getTimeOnThursday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_THURSDAY_TIME) ?? DateTime.now().toString() ;
  }

  Future<String> getTimeOnFriday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_FRIDAY_TIME) ?? DateTime.now().toString() ;
  }

  Future<String> getTimeOnSaturday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_SATURDAY_TIME) ?? DateTime.now().toString() ;
  }

  Future<String> getTimeOnSunday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_SUNDAY_TIME) ?? DateTime.now().toString() ;
  }


  Future<void> setTimeOnMonday(stringTimeOfDay) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("stringTimeOfDay$stringTimeOfDay");

    await prefs.setString(PREF_KEY_NOTIFICATION_MONDAY_TIME, stringTimeOfDay.toString()); //tODO stringTimeOfDayがNullになる
    print("stringTimeOfDay$stringTimeOfDay");

    // await prefs.setString(PREF_KEY_NOTIFICATION_MONDAY_TIME, stringTimeOfDay);
    //  return null;
  }

  Future<void> setTimeOnTuesday(stringTimeOfDay) async{
  // Future<String?> setTimeOnTuesday(stringTimeOfDay) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_TUESDAY_TIME, stringTimeOfDay);
    // return null;
  }

  Future<void> setTimeOnWednesday(stringTimeOfDay) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_WEDNESDAY_TIME, stringTimeOfDay);
    // return null;
  }

  Future<void> setTimeOnThursday(stringTimeOfDay) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_THURSDAY_TIME, stringTimeOfDay);
    // return null;
  }

  Future<void> setTimeOnFriday(stringTimeOfDay) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_FRIDAY_TIME, stringTimeOfDay);
    // return null;
  }

  Future<void> setTimeOnSaturday(stringTimeOfDay) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_SATURDAY_TIME, stringTimeOfDay);
    // return null;
  }

  Future<void> setTimeOnSunday(stringTimeOfDay) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_SUNDAY_TIME, stringTimeOfDay);
    // return null;
  }

  String _changeString(stringTimeOfDay) {
    if (stringTimeOfDay != null) {
        DateTime(
          DateTime.now().year,//DateTime
          DateTime.now().month,//DateTime
          DateTime.now().day,//DateTime
          stringTimeOfDay.hour, // TimeOfDay
          stringTimeOfDay.minute, //TimeOfDay
        ).toString();
        // これで　2022-06-22 10:00:00.000　こんな感じになる
    }
    return stringTimeOfDay;
  }






  //
  // Future<void> readInitTimeForMonday(monday) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString(PREF_KEY_NOTIFICATION_MONDAY_TIME) ?? monday;
  //
  // }
  //
  // Future<void> updateInitTimeForMonday(weekday, time) async{
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     if(weekday == DateTime.monday){
  //       prefs.setString(PREF_KEY_NOTIFICATION_MONDAY_TIME, time);
  //     }else if(weekday == DateTime.tuesday){
  //       prefs.setString(PREF_KEY_NOTIFICATION_TUESDAY_TIME, time);
  //     }else if(weekday == DateTime.wednesday){
  //       prefs.setString(PREF_KEY_NOTIFICATION_WEDNESDAY_TIME, time);
  //     }else if(weekday == DateTime.thursday){
  //       prefs.setString(PREF_KEY_NOTIFICATION_THURSDAY_TIME, time);
  //     }else if(weekday == DateTime.friday){
  //       prefs.setString(PREF_KEY_NOTIFICATION_FRIDAY_TIME, time);
  //     }else if(weekday == DateTime.saturday){
  //       prefs.setString(PREF_KEY_NOTIFICATION_SATURDAY_TIME, time);
  //     }else if(weekday == DateTime.sunday){
  //       prefs.setString(PREF_KEY_NOTIFICATION_SUNDAY_TIME, time);
  //     }
  //
  //     }



  // Future<void> readInitCheck(Key, bool value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getBool(Key, value);
  // }
  //
  //
  // Future<void> updateTime(Key, String time) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(Key, time);
  // }
  //
  // Future<void> updateCheck(Key, bool value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(Key, value);
  // }



}