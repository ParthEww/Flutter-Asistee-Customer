import 'package:flutter_yay_rider_driver/api/model/response/chat/chat_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/preference_state.dart';

part 'preference_notifier.g.dart';

@riverpod
class PreferenceNotifier extends _$Preferencenotifier {

  @override
  PreferenceState build() {
    return PreferenceState(chatList: dummyChatList);
  }
}
