class Member {
  final String generation;
  final Map<String, dynamic> datas;

  Member(this.generation, this.datas);

  String get fullName => datas['full_name'] ?? '';

  String get profPic => datas['profile_image'] ?? '';

  String get linkedIn => datas['linkedin'] ?? '';

  String get email => datas['email'] ?? '';

  String get role => datas['role'] ?? '';
}
