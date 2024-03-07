import 'package:ai_player_a/data/model/chat_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_chat_state.freezed.dart';

@freezed
class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default(false)
    bool isConnecting,
    @Default([])
    List<ChatModel> history,
  }) = _AiChatState;
}
