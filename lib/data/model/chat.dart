import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';

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
