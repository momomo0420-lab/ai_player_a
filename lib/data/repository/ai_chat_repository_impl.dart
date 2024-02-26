import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatDataSource _dataSource;

  const AiChatRepositoryImpl(
    AiChatDataSource dataSource,
  ): _dataSource = dataSource;

  @override
  Future<String> initChat() async {
    return _dataSource.initChat();
  }

  @override
  Stream<String> callAiChat(String message) {
    return _dataSource.callAiChat(message);
  }
}