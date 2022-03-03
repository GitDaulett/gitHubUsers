class UserListModel {
  String? login;
  String? avatarUrl;
  int? id;

  UserListModel({this.avatarUrl, this.login, this.id});

  factory UserListModel.fromJSON(Map<String, dynamic> json) {
    return UserListModel(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      id: json['id'],
    );
  }
}

class All {
  List<UserListModel>? listModel;
  All({this.listModel});

  factory All.fromJSON(List<dynamic> json) {
    List<UserListModel> listModel = <UserListModel>[];
    listModel = json.map((r) => UserListModel.fromJSON(r)).toList();
    return All(listModel: listModel);
  }
}
