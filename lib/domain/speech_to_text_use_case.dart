abstract class SpeechToTextUseCase {
  Future<void> listen(Function(String)? onResult);
  Future<void> stop();
}