import 'package:ai_player_a/common/env.dart';
import 'package:ai_player_a/data/repository/ai_model_repository.dart';
import 'package:ai_player_a/data/repository/ai_model_repository_impl.dart';
import 'package:ai_player_a/domain/speech_to_text_use_case_impl.dart';
import 'package:ai_player_a/domain/text_to_speech_use_case_impl.dart';
import 'package:ai_player_a/domain/text_to_speech_use_case.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'domain/speech_to_text_use_case.dart';

part 'app_container.g.dart';

@riverpod
AiModelRepository aiModelRepository(AiModelRepositoryRef ref) {
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: Env.geminiApiKey,
  );

  final visionModel = GenerativeModel(
    model: 'gemini-pro-vision',
    apiKey: Env.geminiApiKey,
  );

  return AiModelRepositoryImpl(
    model: model,
    visionModel: visionModel,
  );
}

@riverpod
TextToSpeechUseCase textToSpeechUseCase(TextToSpeechUseCaseRef ref) {
  final tts = FlutterTts();
  tts.setLanguage('ja-JP');

  return TextToSpeechUseCaseImpl(tts);
}

@riverpod
SpeechToTextUseCase speechToTextUseCase(SpeechToTextUseCaseRef ref) {
  final stt = SpeechToText();
  return SpeechToTextUseCaseImpl(stt);
}