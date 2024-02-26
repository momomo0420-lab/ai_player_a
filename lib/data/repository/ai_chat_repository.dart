abstract class AiChatRepository {
  Future<String> initChat();
  Stream<String> callAiChat(String message);
}