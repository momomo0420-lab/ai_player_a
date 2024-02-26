import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

part 'ai_consultant_state.freezed.dart';

@freezed
class AiConsultantState with _$AiConsultantState {
  const factory AiConsultantState({
    @Default([])
    List<Message> messages,
    @Default(false)
    bool isConnecting,
  }) = _AiConsultantState;
}
