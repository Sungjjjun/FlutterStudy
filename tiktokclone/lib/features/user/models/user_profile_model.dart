class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String birthday;
  final bool hasAvatar;

  UserProfileModel({
    required this.hasAvatar,
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.birthday,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        bio = '',
        link = '',
        birthday = '',
        hasAvatar = false;

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "birthday": birthday,
    };
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        bio = json['bio'],
        birthday = json['birthday'],
        link = json['link'],
        hasAvatar = json['hasAvatar'] ?? false;

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      hasAvatar: hasAvatar ?? this.hasAvatar,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      birthday: birthday ?? this.birthday,
    );
  }
}
