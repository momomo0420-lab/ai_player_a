abstract class AiChatRepository {
  Future<String> callAiChat(String message);
  Stream<String> callAiChat2(String message);
}