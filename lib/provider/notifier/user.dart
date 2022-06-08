import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../model/model.dart';

class UserState extends StateNotifier<ModelUser?> {
  UserState() : super(null);

  String sessionId = "";
  String token = "";
  ModelUser user = ModelUser();

  Future<void> login({
    TMDB? tmdb,
    String? username,
    String? password,
  }) async {
    var sessionLogin = await tmdb!.v3.auth.createSessionWithLogin(
      username!,
      password!,
    );
    var sessionId = await tmdb.v3.auth.createSession(sessionLogin);
    var account = await tmdb.v3.account.getDetails(sessionId);
    var box = Hive.box('setting');
    box.put("sessionId", sessionLogin);
    sessionId = sessionId;
    user = ModelUser.fromJson(account as Map<String, dynamic>);
    state = user;
  }

  Future<void> setUser(ModelUser data) async {
    user = data;
    state = data;
  }

  Future<void> logout() async {
    sessionId = "";
    token = "";
    user = ModelUser();
    state = null;
  }
}
