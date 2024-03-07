import 'package:ai_player_a/data/model/chat_model.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository_2.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiChatRepository2Impl implements AiChatRepository2 {
  final GenerativeModel _model;

  const AiChatRepository2Impl({
    required GenerativeModel model,
  }): _model = model;

  @override
  Stream<String> callAiChat({
    required List<ChatModel> history,
    required String message,
  }) async* {
    final historyContents = _buildHistoryContents(history);
    final chat = _model.startChat(
      history: historyContents,
    );
    final response = chat.sendMessageStream(Content.text(message));

    await for(var chunk in response) {
      final text = chunk.text;

      if(text != null) yield text;
    }
  }

  List<Content> _buildHistoryContents(List<ChatModel> history) {
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