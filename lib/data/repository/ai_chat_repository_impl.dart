import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatDataSource _dataSource;

  const AiChatRepositoryImpl(
    AiChatDataSource dataSource,
  ): _dataSource = dataSource;

  @override
  Stream<String> callAiChat(String message) {
    return _dataSource.callAiChat(message);
  }

  @override
  Future<String> callAiChat2(String message) async {
    return _dataSource.callAiChat2(message);
  }
}