import 'package:ai_player_a/domain/speech_to_text_use_case.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextUseCaseImpl implements SpeechToTextUseCase {
  final SpeechToText _stt;

  const SpeechToTextUseCaseImpl(
    SpeechToText stt,
  ): _stt = stt;

  @override
  Future<void> listen(Function(String)? onResult) async {
    final result = await _stt.initialize();
    if(!result) return;

    await _stt.listen(
      localeId: 'ja_JP',
      onResult: (result) {
        if(onResult == null) return;

        final word = result.recognizedWords;
        onResult(word);
      }
    );
  }

  @override
  Future<void> stop() async {
    await _stt.stop();
  }
}