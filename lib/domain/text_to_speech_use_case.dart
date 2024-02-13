abstract class TextToSpeechUseCase {
  Future<void> speak(String text);
  Future<void> stop();
}