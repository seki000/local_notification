
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
const PREF_KEY_NOTIFICATION_REPEAT_CHECK = "repeat_check_id";



class SharedPrefsManager {

  //曜日ごとのチェックボックスの値の読み込み
  Future<bool> getBoolOnMonday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_MONDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnTuesday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_TUESDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnWednesday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_WEDNESDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnThursday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_THURSDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnFriday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_FRIDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnSaturday() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     return await prefs.getBool(PREF_KEY_NOTIFICATION_SATURDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnSunday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_SUNDAY_CHECK)  ?? false;
  }

  Future<bool> getBoolOnEveryday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_EVERYDAY_CHECK)  ?? false;
  }




  //曜日ごとのチェックボックスの値の保存
  Future<bool> setBoolOnMonday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_MONDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnTuesday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_TUESDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnWednesday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_WEDNESDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnThursday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_THURSDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnFriday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_FRIDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnSaturday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_SATURDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnSunday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_SUNDAY_CHECK, isChecked);
  }

  Future<bool> setBoolOnEveryday(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_EVERYDAY_CHECK, isChecked);
  }

  //曜日ごとのDateTime読み込み
  Future<String> getTimeOnMonday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_MONDAY_TIME) ?? DateTime.now().toString() ;
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

  Future<String> getTimeOnEveryday() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(PREF_KEY_NOTIFICATION_EVERYDAY_TIME) ?? DateTime.now().toString() ;
  }


  //曜日ごとのDateTime保存
  Future<void> setTimeOnMonday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_MONDAY_TIME, stringTime);
  }

  Future<void> setTimeOnTuesday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_TUESDAY_TIME, stringTime);
  }

  Future<void> setTimeOnWednesday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_WEDNESDAY_TIME, stringTime);
  }

  Future<void> setTimeOnThursday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_THURSDAY_TIME, stringTime);
  }

  Future<void> setTimeOnFriday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_FRIDAY_TIME, stringTime);
  }

  Future<void> setTimeOnSaturday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_SATURDAY_TIME, stringTime);
  }

  Future<void> setTimeOnSunday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_SUNDAY_TIME, stringTime);
  }

  Future<void> setTimeOnEveryday(stringTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_KEY_NOTIFICATION_EVERYDAY_TIME, stringTime);
  }

  Future<bool> setBoolOnRepeat(isChecked) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(PREF_KEY_NOTIFICATION_REPEAT_CHECK, isChecked);
  }

  Future<bool> getBoolOnRepeat() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(PREF_KEY_NOTIFICATION_REPEAT_CHECK)  ?? false;
  }

}