import 'package:flutter/material.dart';
import 'package:github_users/gh_users/models/user_profile_model.dart';

class UserDetails extends StatelessWidget {
  static const String id = 'user_details';

  final String? login;
  final Future<UserProfileModel>? profileData;

  const UserDetails({this.login, this.profileData});

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
          title: Text('User Details'),
          backgroundColor: Colors.blueGrey,
        ),
        body: FutureBuilder<UserProfileModel>(
          future: profileData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data!.avatarUrl!.toString()),
                      radius: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      snapshot.data!.name!,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DetailCard(
                            width: 100,
                            title: 'Following:',
                            content: snapshot.data!.following!.toString(),
                          ),
                          DetailCard(
                            width: 100,
                            title: 'Followers:',
                            content: snapshot.data!.followers!.toString(),
                          )
                        ]),
                    SizedBox(height: 10),
                    DetailCard(
                      width: 300,
                      title: 'Email:',
                      content: snapshot.data!.email == ''
                          ? 'No such record'
                          : snapshot.data!.email!,
                    ),
                    SizedBox(height: 10),
                    DetailCard(
                      width: 300,
                      title: 'Company:',
                      content: snapshot.data!.email == ''
                          ? 'No such record'
                          : snapshot.data!.company!,
                    ),
                    SizedBox(height: 10),
                    DetailCard(
                      width: 300,
                      title: 'Account creation date:',
                      content: snapshot.data!.createdAt!.substring(0, 10),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error!'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class DetailCard extends StatelessWidget {
  final double? width;
  final String? title;
  final String? content;

  const DetailCard({this.width, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green[400]!),
          borderRadius: BorderRadius.circular(15),
          color: Colors.green[100]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(title!),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Text(
              content!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
