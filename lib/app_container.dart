import 'package:ai_player_a/common/env.dart';
import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:ai_player_a/data/data_source/ai_chat_data_source_impl.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository_impl.dart';
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
AiChatDataSource aiChatDataSource(AiChatDataSourceRef ref) {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: Env.geminiApiKey);
  return AiChatDataSourceImpl(model);
}

@riverpod
AiChatRepository aiChatRepository(AiChatRepositoryRef ref) {
  final dataSource = ref.watch(aiChatDataSourceProvider);
  return AiChatRepositoryImpl(dataSource);
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