import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/account.dart';

class AccountNotifier extends StateNotifier<ModelAccount?> {
  AccountNotifier() : super(null);
  late ModelAccount data;
  add(ModelAccount account) {
    data = account;
    state = data;
  }
}
