import 'package:contoh/model/account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountNotifier extends StateNotifier<ModelAccount?> {
  AccountNotifier() : super(null);
  late ModelAccount data;
  add(ModelAccount account) {
    data = account;
    state = data;
  }
}
