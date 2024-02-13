abstract class AiChatDataSource {
  Stream<String> callAiChat(String message);
  Future<String> callAiChat2(String message);
}