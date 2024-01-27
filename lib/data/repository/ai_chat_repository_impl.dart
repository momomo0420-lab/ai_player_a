import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository.dart';
import 'package:flutter/material.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatDataSource _dataSource;

  const AiChatRepositoryImpl(
    AiChatDataSource dataSource,
  ): _dataSource = dataSource;

  @override
  Future<String> callAiChat(String message) async {
    debugPrint('askAiChat: message');
    await Future.delayed(const Duration(seconds: 3));

    return _createMessage();
  }

  String _createMessage() {
    return 'こんにちは＾＾\n'
      + '今日はどのようなご用件ですか？\n';
  }

  @override
  Stream<String> callAiChat2(String message) {
    return _dataSource.callAiChat(message);
  }
}