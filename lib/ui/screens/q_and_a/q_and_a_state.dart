import 'package:ai_player_a/data/model/chat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'q_and_a_state.freezed.dart';

@freezed
class QAndAState with _$QAndAState{
  const factory QAndAState({
    @Default([])
    List<Chat> chatList,
    @Default(false)
    bool isLoading,
    @Default(false)
    bool isRecording,
    @Default(true)
    bool isEmptyWithTextField,
  }) = _QAndAState;
}
