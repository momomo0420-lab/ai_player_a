import 'package:ai_player_a/domain/stt_use_case.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SttUseCaseImpl implements SttUseCase {
  final SpeechToText _stt;

  const SttUseCaseImpl(
    SpeechToText stt,
  ): _stt = stt;

  @override
  Future<void> listen(Function(String)? onResult) async {
    await _stt.listen(onResult: (result) {
      if(onResult == null) return;

      final word = result.recognizedWords;
      onResult(word);
    });
  }

  @override
  Future<void> stop() async {
    await _stt.stop();
  }

}