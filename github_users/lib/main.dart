import 'package:flutter/material.dart';
import 'package:github_users/gh_users/screens/main_list_screen.dart';
import 'package:github_users/gh_users/screens/user_details_screen.dart';
import 'package:github_users/gh_users/local_storage/local_storage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimple.init();
  runApp(const GitHubUsersApp());
}

class GitHubUsersApp extends StatelessWidget {
  const GitHubUsersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MainList.id,
      routes: {
        MainList.id: (context) => MainList(),
        UserDetails.id: (context) => UserDetails()
      },
    );
  }
}
