import 'dart:io';
import 'package:github_users/gh_users/models/user_list_model.dart';
import 'package:github_users/gh_users/models/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//ADD Personal Access Token for GitHub API
String apiToken = '';

Future<All> fetchUsers(int? page) async {
  http.Response response = await http.get(
    Uri.parse('https://api.github.com/users?since=$page&per_page=100'),
    headers: {HttpHeaders.authorizationHeader: "token $apiToken"},
  );
  if (response.statusCode == 200) {
    // debugPrint(response.body);
    return All.fromJSON(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch users!');
  }
}

Future<UserProfileModel> fetchProfile(String? login) async {
  http.Response response = await http.get(
    Uri.parse('https://api.github.com/users/$login'),
    headers: {HttpHeaders.authorizationHeader: "token $apiToken"},
  );
  if (response.statusCode == 200) {
    // debugPrint(response.body);
    return UserProfileModel.fromJSON(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch profile!');
  }
}
