import 'package:shared_preferences/shared_preferences.dart';

class UserSimple {
  static SharedPreferences? pref;

  static const keyLoginList = 'loginList';
  static const keyIdList = 'idList';
  static const keyAvatarList = 'avatarList';

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  //
  static Future setLoginList(List<String> loginList) async =>
      await pref!.setStringList(keyLoginList, loginList);

  static Future setIdList(List<String> idList) async =>
      await pref!.setStringList(keyIdList, idList);

  static Future setAvatarList(List<String> avatarList) async =>
      await pref!.setStringList(keyAvatarList, avatarList);
  //
  static List<String>? getLoginList() => pref!.getStringList(keyLoginList);
  static List<String>? getIdList() => pref!.getStringList(keyIdList);
  static List<String>? getAvatarList() => pref!.getStringList(keyAvatarList);
  //

}
