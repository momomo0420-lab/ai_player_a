import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

enum Authors {
  ai,
  user;
}

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel ({
    required Authors author,
    @Default('')
    String message,
  }) = _MessageModel;
}
