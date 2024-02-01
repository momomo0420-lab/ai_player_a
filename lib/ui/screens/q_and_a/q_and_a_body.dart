import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_state.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_view_model.dart';
import 'package:ai_player_a/ui/widget/one_line_text_field.dart';
import 'package:ai_player_a/ui/widget/recv_message_container.dart';
import 'package:ai_player_a/ui/widget/send_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QAndABody extends HookWidget {
  final QAndAState _state;
  final QAndAViewModel _viewModel;

  const QAndABody({
    super.key,
    required QAndAState state,
    required QAndAViewModel viewModel,
  }): _state = state,
        _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Column(
      children: [
        Expanded(
          child: _buildChatListView(
            _state.chatList,
            controller: controller,
          ),
        ),

        _buildOneListTextField(),
      ],
    );
  }

  Widget _buildChatListView(
    List<Chat> chatList, {
    ScrollController? controller,
  }) {
    return ListView.builder(
      controller: controller,
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        final chat = chatList[index];

        Widget container;

        if(chat.author == Authors.ai.name) {
          container = recvMessageContainer(context, chat.message);
        } else {
          container = sendMessageContainer(context, chat.message);
        }

        return container;
      },
    );
  }

  Widget _buildOneListTextField() {
    return oneLineTextField(
      controller: useTextEditingController(),
      hint: 'メッセージを入力してください',
      isLoading: _state.isLoading,
      isSendable: _state.isSendable,
      onChanged: (text) {
        bool isSendable = true;
        if(text == '') isSendable = false;

        _viewModel.setSendable(isSendable);
      },
      onSend: (message) {
        FocusManager.instance.primaryFocus?.unfocus();
        _viewModel.callAiChat(message);
        _viewModel.setSendable(false);
        // controller.animateTo(
        //   controller.position.maxScrollExtent,
        //   duration: const Duration(seconds: 1),
        //   curve: Curves.linear,
        // );
      },
    );
  }
}
