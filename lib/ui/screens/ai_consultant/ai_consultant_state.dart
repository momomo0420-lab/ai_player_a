import 'package:ai_player_a/data/model/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_consultant_state.freezed.dart';

@freezed
class AiConsultantState with _$AiConsultantState {
  const factory AiConsultantState({
    @Default(false)
    bool isConnecting,
    @Default([])
    List<MessageModel> history,
  }) = _AiConsultantState;
}
