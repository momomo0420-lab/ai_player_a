import 'package:ai_player_a/data/model/chat_model.dart';
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
    return Column(
      children: [
        Expanded(
          child: _buildChatListView(
            _state.chatList,
            ScrollController(),
          ),
        ),

        _buildOneListTextField(),
      ],
    );
  }

  Widget _buildChatListView(
    List<ChatModel> chatList,
    ScrollController controller,
  ) {
    return ListView.builder(
      controller: controller,
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        final chat = chatList[index];

        Widget container;

        if(chat.author == Authors.ai) {
          container = recvMessageContainer(context, chat.message);
        } else {
          container = sendMessageContainer(context, chat.message);
          // if(_state.isLoading) {
          //   controller.jumpTo(controller.position.maxScrollExtent);
          // }
        }

        return container;
      },
    );
  }

  Widget _buildOneListTextField() {
    return OneLineTextField(
      controller: useTextEditingController(),
      hint: 'メッセージを入力してください',
      sendButtonState: _viewModel.isSendButtonState(),
      onChanged: _viewModel.changeTextField,
      onSend: _viewModel.callAiChat,
      onRec: _viewModel.startListening,
      onStop: _viewModel.stopListening,
    );
  }
}
