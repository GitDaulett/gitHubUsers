class UserProfileModel {
  String? name;
  String? avatarUrl;
  String? email;
  String? company;
  int? followers;
  int? following;
  String? createdAt;

  UserProfileModel({
    this.avatarUrl,
    this.name,
    this.email,
    this.company,
    this.followers,
    this.following,
    this.createdAt,
  });

  factory UserProfileModel.fromJSON(Map<String, dynamic> json) {
    return UserProfileModel(
        followers: json['followers'],
        following: json['following'],
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        avatarUrl: json['avatar_url'],
        company: json['company'] ?? '',
        createdAt: json['created_at']);
  }
}
