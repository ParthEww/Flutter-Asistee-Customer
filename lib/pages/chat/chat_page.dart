
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_yay_rider_driver/api/model/response/chat/chat_model.dart';
import 'package:flutter_yay_rider_driver/core/themes/text_styles.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';
import 'package:flutter_yay_rider_driver/core/widgets/custom/custom_circle_icon.dart';
import 'package:flutter_yay_rider_driver/pages/chat/notifier/chat_notifier.dart';
import 'package:flutter_yay_rider_driver/pages/chat/state/chat_state.dart';
import 'package:intl/intl.dart';

import '../../../gen/assets.gen.dart';
import '../../core/themes/app_colors.dart';
import '../../core/widgets/custom/custom_header.dart';
import '../../di/app_provider.dart';
import '../../routes/navigation_service.dart';
import '../splash/notifier/splash_notifier.dart';

class ChatPage extends ConsumerWidget {

  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final NavigationService navigationService = ref.read(navigationServiceProvider);
    final authState = ref.watch(chatNotifierProvider);
    final authNotifier = ref.read(chatNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Background with 30% primary color and 70% white
          _buildBackground(context),

          // Main content with SafeArea
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar
                _buildAppBar(navigationService),

                // Scrollable content area
                Expanded(
                  child: _buildScrollableContent(context, authState.chatList, authNotifier),
                ),

                sendMessageView(onMessage: (string){})
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Builds the background with two colored sections
  Widget _buildBackground(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.21,
          color: AppColors.primary,
        ),
        Expanded(
          child: Container(
            color: AppColors.white,
          ),
        )
      ],
    );
  }

  /// Builds the custom app bar with back button and titles
  Widget _buildAppBar(NavigationService navigationService) {
    return Container(
      color: AppColors.primary,
      child: CustomHeader(
          title: "Admin Chat",
          isShowSubtitle: false,
          isShowBackButton: true,
          onBackButtonTap: () {
            navigationService.pop();
          }),
    );
  }

  /// Builds the main scrollable content
  Widget _buildScrollableContent(BuildContext context, List<ChatModel> message, ChatNotifier authNotifier) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 54, right: 24),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AppColors.white, width: 6),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 4, top: 4, right: 24, bottom: 4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCircleIcon(
                        iconPath: Assets.images.svg.settingsAboutUs.path,
                        backgroundColor: AppColors.deepNavy,
                      ),
                      Text(
                        "Super Admin",
                        style: TextStyles.text16SemiBold.copyWith(color: AppColors.deepNavy),
                      )
                    ]),
              )),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: message.length,
              itemBuilder: (BuildContext context, int index) {
                final showDate = authNotifier.shouldShowDateLabel(message, index, DateFormat("yyyy-MM-dd"));
                return buildChatMessage(context, message[index], showDate, authNotifier);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 18);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildChatMessage(BuildContext context, ChatModel message, bool showLabel, ChatNotifier authNotifier) {
    return Column(
      children: [
        if (showLabel) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(Assets.images.svg.line3.path),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(51)),
                      border:
                      Border.all(color: AppColors.white, width: 1)),
                  child: Text(
                    authNotifier.getFormattedDate(message.createdAt),
                    style: TextStyles.text12SemiBold,
                  ),
                )
              ],
            ),
          ),
        ],
        Align(
          alignment: (message.isSender ?? false) ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 0.7 * MediaQuery.of(context).size.width,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!(message.isSender ?? false)) ...<Widget>[
                    // Receiver image
                    Column(
                      children: [
                        CustomCircleIcon(
                          iconPath: Assets.images.svg.settingsAboutUs.path,
                          backgroundColor: AppColors.deepNavy,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!(message.isSender ?? false)) ...[
                          // Receiver name
                          Text(
                            'Super Admin',
                            style: TextStyles.text12Regular.copyWith(color: AppColors.primary.withOpacityPrecise(0.6)),
                          ),
                          const SizedBox(height: 6),
                        ],
                        // Message bubble
                        Container(
                          decoration: BoxDecoration(
                            color: (message.isSender ?? false) ? AppColors.chatGray : AppColors.chatGreen,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular((message.isSender ?? false) ? 20 : 0),
                              topRight: Radius.circular((message.isSender ?? false) ? 0 : 20),
                              bottomLeft: const Radius.circular(20),
                              bottomRight: const Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Message text
                              Text(
                                message.content ?? 'Test Text',
                                style: TextStyles.text14Regular.copyWith(color: AppColors.deepNavy),
                                maxLines: 70,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              // Message time
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  message.messageTime ?? '',
                                  style: TextStyle(
                                    color: Colors.blueGrey.withOpacity(0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sendMessageView({
    required Function(String) onMessage,
  }) {
    final TextEditingController controller = TextEditingController();

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1),
              borderRadius: BorderRadius.circular(82),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Write your message...",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      if (controller.text.trim().isNotEmpty) {
                        onMessage(controller.text.trim());
                        controller.clear();
                        setState(() {});
                      }
                    },
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: controller.text.trim().isNotEmpty
                            ? AppColors.primary
                            : AppColors.primary.withOpacityPrecise(0.5),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child:
                          SvgPicture.asset(Assets.images.svg.send.path),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}