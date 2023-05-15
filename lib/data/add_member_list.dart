import 'user.dart';

class AddMemberList {
  List<User> memberList;

  AddMemberList({
    required this.memberList,
  });

  factory AddMemberList.fromJson(Map<String, dynamic> json) => AddMemberList(
    memberList: List<User>.from(
      json["candidate_users"].map(
              (x) => User.fromJson(x)
      ),
    ),
  );
}