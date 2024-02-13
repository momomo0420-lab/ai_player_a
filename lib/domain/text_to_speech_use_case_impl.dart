import 'package:ai_player_a/domain/text_to_speech_use_case.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechUseCaseImpl implements TextToSpeechUseCase {
  final FlutterTts _tts;

  const TextToSpeechUseCaseImpl(
    FlutterTts tts,
  ): _tts = tts;

  @override
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }
}