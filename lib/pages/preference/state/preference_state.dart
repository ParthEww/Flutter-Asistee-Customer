import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../api/model/response/chat/chat_model.dart';

part 'preference_state.freezed.dart';

@freezed
class PreferenceState with _$PreferenceState {
  const factory PreferenceState({
    @Default([]) List<ChatModel> chatList,
  }) = _PreferenceState;
}