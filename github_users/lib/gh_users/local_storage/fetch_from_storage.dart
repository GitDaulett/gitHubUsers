import 'local_storage.dart';

List<String>? loginList = [];
List<String>? idList = [];
List<String>? avatarList = [];

class StorageLists {
  //
  setLists(String? login, String? id, String? avatar) async {
    loginList!.add(login!);
    idList!.add(id!);
    avatarList!.add(avatar!);
    //
    await UserSimple.setLoginList(loginList!.toSet().toList());
    await UserSimple.setIdList(idList!.toSet().toList());
    await UserSimple.setAvatarList(avatarList!.toSet().toList());
  }

  //
  getList() async {
    loginList = UserSimple.getLoginList();
    idList = UserSimple.getIdList();
    avatarList = UserSimple.getAvatarList();
  }
}
