import 'package:flutter/material.dart';
import 'package:github_users/gh_users/api_service/networking.dart';
import 'package:github_users/gh_users/models/user_list_model.dart';
import 'user_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:github_users/gh_users/local_storage/fetch_from_storage.dart';

int count = 20;
int page = 0;

class MainList extends StatefulWidget {
  static const String id = 'main_list';
  const MainList({Key? key}) : super(key: key);

  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  Future<All>? _futureUserList;
  //
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshController1 =
      RefreshController(initialRefresh: false);
  //
  List<UserListModel>? listModel = <UserListModel>[];
  //
  StorageLists storage = StorageLists();
  //
  @override
  void initState() {
    super.initState();
    _futureUserList = fetchUsers(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        title: Text('GitHub Users'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: FutureBuilder<All>(
            future: _futureUserList!,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.listModel!;
                for (int i = 0; i < snap.length; i++) {
                  listModel!.add(
                    UserListModel(
                        login: snap[i].login!,
                        id: snap[i].id!,
                        avatarUrl: snap[i].avatarUrl!),
                  );
                }
                return SmartRefresher(
                  enablePullUp: true,
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  controller: refreshController,
                  enablePullDown: true,
                  header: WaterDropMaterialHeader(
                    offset: -1,
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: ListView.builder(
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: index == 0
                              ? EdgeInsets.only(top: 12, bottom: 5)
                              : EdgeInsets.symmetric(vertical: 5),
                          child: UserCardModel(
                            onPress: () {
                              //
                              storage.setLists(
                                  snap[index].login!,
                                  snap[index].id!.toString(),
                                  snap[index].avatarUrl);
                              //
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UserDetails(
                                  login: snap[index].login!,
                                  profileData: fetchProfile(snap[index].login!),
                                );
                              }));
                            },
                            login: snap[index].login!,
                            id: snap[index].id!.toString(),
                            avatar: snap[index].avatarUrl!,
                          ));
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Something goes wrong!\nCheck your Internet connection!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: SmartRefresher(
                      enablePullDown: true,
                      controller: refreshController1,
                      onRefresh: _onRefresh1,
                      header: WaterDropHeader(),
                      child: ListView.builder(
                        itemCount: loginList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: index == 0
                                  ? EdgeInsets.only(top: 12, bottom: 5)
                                  : EdgeInsets.symmetric(vertical: 5),
                              child: UserCardModel(
                                onPress: () {},
                                login: loginList![index],
                                id: idList![index],
                                avatar: avatarList![index],
                              ));
                        },
                      ),
                    ))
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (count < 100) {
      setState(() {
        count = count + 5;
      });
    } else {
      setState(() {
        count = 100;
        page = page + 5;
        _futureUserList = fetchUsers(page);
      });
    }

    refreshController.loadComplete();
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      storage.getList();
      count = 20;
      _futureUserList = fetchUsers(0);
    });
    refreshController.refreshCompleted();
  }

  _onRefresh1() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      storage.getList();
      count = 20;
      _futureUserList = fetchUsers(0);
    });
    refreshController1.refreshCompleted();
  }
}

class UserCardModel extends StatelessWidget {
  final VoidCallback? onPress;
  final String? login;
  final String? id;
  final String? avatar;
  const UserCardModel({this.login, this.id, this.avatar, this.onPress});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress!,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green[400]!),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(35),
                bottomRight: Radius.circular(35)),
            color: Colors.green[100]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(avatar!),
              backgroundColor: Colors.grey,
              radius: 50,
            ),
            Column(
              children: [
                Text(
                  login!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'id:' + id!,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            SizedBox(width: 1),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
