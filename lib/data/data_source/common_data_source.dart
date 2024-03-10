import 'package:ai_player_a/data/model/message_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class CommonDataSource {
  static List<Content> buildHistoryContents(List<MessageModel> history) {
    List<Content> historyContents = [];

    for(var chatModel in history) {
      late final Content content;

      if(chatModel.author == Authors.ai) {
        content = Content.model([TextPart(chatModel.message)]);
      } else {
        content = Content.text(chatModel.message);
      }

      historyContents.add(content);
    }

    return historyContents;
  }
}