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

enum Authors {
  ai,
  user;
}

@freezed
class Chat with _$Chat {
  const factory Chat ({
    required Authors author,
    @Default('')
    String message,
  }) = _Chat;
}
