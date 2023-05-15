import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_management/data/add_member_list.dart';

class AddMemberListProvider extends StateNotifier<AddMemberList?> {

  AddMemberListProvider() : super(null);

  Future<AddMemberList> getAddMemberList(final teamName) async {

    String endpoint = "http://10.0.2.2:8000/add_member_list/";

    Response response = await post(
        Uri.parse(endpoint),
        body: {
          "team_name": teamName
        }
    );

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final addMemberList = AddMemberList.fromJson(json);

      setAddMemberList = addMemberList;

      return addMemberList;
    }

    throw Exception(response.reasonPhrase);
  }

  AddMemberList? get value => state;

  set setAddMemberList(AddMemberList? val) {
    state = val;
  }

}

final addMemberListProvider = StateNotifierProvider<AddMemberListProvider, AddMemberList?>(
      (ref) => AddMemberListProvider(),
);