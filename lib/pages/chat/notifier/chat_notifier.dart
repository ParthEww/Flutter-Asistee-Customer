
import 'package:flutter_yay_rider_driver/api/model/response/chat/chat_model.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/chat_state.dart';

part 'chat_notifier.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier{

  @override
  ChatState build() {
    state = ChatState(chatList: dummyChatList);
    return state;
  }

  String getFormattedDate(String? createdAt) {
    if (createdAt == null) return '';

    try {
      final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
      final createdDateTime = formatter.parse(createdAt, true);
      final today = DateTime.now();
      final yesterday = DateTime(today.year, today.month, today.day - 1);

      if (createdDateTime.year == today.year &&
          createdDateTime.month == today.month &&
          createdDateTime.day == today.day) {
        return 'Today';
      } else if (createdDateTime.year == yesterday.year &&
          createdDateTime.month == yesterday.month &&
          createdDateTime.day == yesterday.day) {
        return 'Yesterday';
      } else {
        return DateFormat('d MMM').format(createdDateTime);
      }
    } catch (e) {
      return createdAt; // Return original string if parsing fails
    }
  }

  bool shouldShowDateLabel(List<ChatModel> messagesList, int index, DateFormat formatter) {
    DateTime? previousDate;
    final currentItem = messagesList[index];

    if (index < messagesList.length - 1) {
      final previousItem = messagesList[index + 1];
      previousDate = formatter.parse(previousItem.createdAt ?? '');
    }

    final currentDate = formatter.parse(currentItem.createdAt ?? '');

    return previousDate == null || !isSameDay(currentDate, previousDate);
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }


}