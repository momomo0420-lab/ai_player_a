import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_state.dart';
import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class AiConsultantBody extends StatelessWidget {
  final AiConsultantState _state;
  final AiConsultantViewModel _viewModel;

  const AiConsultantBody({
    super.key,
    required AiConsultantState state,
    required AiConsultantViewModel viewModel,
  }): _state = state,
        _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Chat(
          messages: _state.messages,
          onSendPressed: (message) => _onSendPressed(context, message),
          user: _viewModel.getUser(),
        ),

        Center(
          child: _buildIndicator(),
        ),
      ],
    );
  }

  Widget _buildIndicator() {
    Widget widget;

    if(_state.isConnecting) {
      widget = const CircularProgressIndicator();
    } else {
      widget = Container();
    }

    return widget;
  }

  void _onSendPressed(BuildContext context, PartialText message) {
    if(_state.isConnecting) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('通信中のため入力できません。')),
      );
      return;
    }
    
    _viewModel.sendMessage(message);
  }
}
