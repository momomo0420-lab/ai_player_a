import 'package:ai_player_a/data/model/message_model.dart';

abstract class AiChatDataSource {
  Stream<String> call({
    required List<MessageModel> history,
    required String message,
  });
}