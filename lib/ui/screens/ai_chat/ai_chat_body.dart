import 'package:ai_player_a/data/model/message_model.dart';
import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_state.dart';
import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class AiChatBody extends StatelessWidget {
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
    return Stack(
      children: [
        Chat(
          messages: _buildMessages(_state.history),
          onSendPressed: (message) => _onSendPressed(context, message),
          user: types.User(id: Authors.user.name),
        ),

        Center(
          child: _buildIndicator(),
        ),
      ],
    );
  }

  List<types.Message> _buildMessages(List<MessageModel> history) {
    List<types.Message> messages = [];

    for(var chat in history) {
      late final types.User author;

      if(chat.author == Authors.ai) {
        author = types.User(id: Authors.ai.name);
      } else {
        author = types.User(id: Authors.user.name);
      }

      final message = types.TextMessage(
        author: author,
        id: const Uuid().v4(),
        text: chat.message,
      );

      messages.insert(0, message);
    }

    return messages;
  }

  Widget _buildIndicator() {
    Widget widget = Container();

    if(_state.isConnecting) {
      widget = const CircularProgressIndicator();
    }

    return widget;
  }

  void _onSendPressed(BuildContext context, types.PartialText message) {
    if(_state.isConnecting) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('通信中のため入力できません。')),
      );
      return;
    }

    _viewModel.sendMessage(message.text);
  }
}
