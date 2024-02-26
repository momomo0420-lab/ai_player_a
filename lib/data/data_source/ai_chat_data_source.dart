abstract class AiChatDataSource {
  Future<String> initChat();
  Stream<String> callAiChat(String message);
}