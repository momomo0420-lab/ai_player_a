import 'package:speech_to_text/speech_recognition_result.dart';

abstract class SttUseCase {
  Future<void> listen(Function(String)? onResult);
  Future<void> stop();
}