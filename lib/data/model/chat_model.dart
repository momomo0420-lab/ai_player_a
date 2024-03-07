import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';

enum Authors {
  ai,
  user;
}

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel ({
    required Authors author,
    @Default('')
    String message,
  }) = _ChatModel;
}
