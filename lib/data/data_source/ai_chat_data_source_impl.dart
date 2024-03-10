import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:ai_player_a/data/data_source/common_data_source.dart';
import 'package:ai_player_a/data/model/message_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiChatDataSourceImpl implements AiChatDataSource {
  final GenerativeModel _model;

  const AiChatDataSourceImpl(
    GenerativeModel model,
  ): _model = model;

  @override
  Stream<String> call({
    required List<MessageModel> history,
    required String message,
  }) async* {
    final historyContents = CommonDataSource.buildHistoryContents(history);
    final chat = _model.startChat(
      history: historyContents,
    );
    final response = chat.sendMessageStream(Content.text(message));

    await for(var chunk in response) {
      final text = chunk.text;

      if(text != null) yield text;
    }
  }
}