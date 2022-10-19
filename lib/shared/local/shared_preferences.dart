import 'package:shared_preferences/shared_preferences.dart';

class CatchHelper{

 static SharedPreferences? sharedPreferences;

 static  init()async{
   sharedPreferences= await SharedPreferences.getInstance();
 }
  static Future<bool> saveData({required String Key,required dynamic value})async
 {
if(value is String) return sharedPreferences!.setString(Key,value);
if(value is int) return sharedPreferences!.setInt(Key,value);
if(value is bool) return sharedPreferences!.setBool(Key,value);
 return await sharedPreferences!.setDouble(Key,value);

 }
 static dynamic getData({required String Key})
 {
    return sharedPreferences!.get(Key);

 }
 static Future<bool> removeData({required String Key}) async
 {
  return  await sharedPreferences!.remove(Key);

 }
}