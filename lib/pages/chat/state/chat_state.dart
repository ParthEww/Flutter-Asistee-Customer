import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../api/model/response/chat/chat_model.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatModel> chatList,
  }) = _ChatState;
}
