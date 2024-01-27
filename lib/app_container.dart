import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:ai_player_a/data/data_source/ai_chat_data_source_impl.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository_impl.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_container.g.dart';

@riverpod
AiChatDataSource aiChatDataSource(AiChatDataSourceRef ref) {
  return AiChatDataSourceImpl(Gemini.instance);
}

@riverpod
AiChatRepository aiChatRepository(AiChatRepositoryRef ref) {
  final dataSource = ref.watch(aiChatDataSourceProvider);
  return AiChatRepositoryImpl(dataSource);
}
