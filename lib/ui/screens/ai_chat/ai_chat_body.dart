import 'package:ai_player_a/data/model/chat.dart';
import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_state.dart';
import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_view_model.dart';
import 'package:ai_player_a/ui/widget/one_line_text_field.dart';
import 'package:ai_player_a/ui/widget/recv_message_container.dart';
import 'package:ai_player_a/ui/widget/send_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AiChatBody extends HookWidget {
  final AiChatState _state;
  final AiChatViewModel _viewModel;

  const AiChatBody({
    super.key,
    required AiChatState state,
    required AiChatViewModel viewModel,
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
      List<Chat> chatList,
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
