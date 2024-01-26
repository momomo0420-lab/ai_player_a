import 'package:ai_player_a/data/repository/ai_chat_repository.dart';
import 'package:flutter/material.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  @override
  Future<String> callAiChat(String message) async {
    debugPrint('askAiChat: message');
    await Future.delayed(const Duration(seconds: 3));

    return _createMessage();
  }

  String _createMessage() {
    return 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n'
      + 'aaaaaaaaaaaaaaaaaaaaa\n'
      + 'bbbbbbbbbbbbbbbbbbbbbbbbb\n'
      + 'cccccccccccccccccccccccc\n';
  }
}