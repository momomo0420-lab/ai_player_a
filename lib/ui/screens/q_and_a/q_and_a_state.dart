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
    bool isSendable,
  }) = _QAndAState;
}

@freezed
class Chat with _$Chat {
  const factory Chat ({
    @Default('')
    String author,
    @Default('')
    String message,
  }) = _Chat;
}
