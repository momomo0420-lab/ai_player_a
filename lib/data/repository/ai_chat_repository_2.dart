import 'package:ai_player_a/data/model/chat_model.dart';

abstract class AiChatRepository2 {
  Stream<String> callAiChat({
    required List<ChatModel> history,
    required String message,
  });
}