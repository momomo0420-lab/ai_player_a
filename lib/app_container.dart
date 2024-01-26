import 'package:ai_player_a/data/repository/ai_chat_repository.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_container.g.dart';

@riverpod
AiChatRepository aiChatRepository(AiChatRepositoryRef ref) {
  return AiChatRepositoryImpl();
}
