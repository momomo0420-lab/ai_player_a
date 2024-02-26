import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiChatDataSourceImpl implements AiChatDataSource {
  final ChatSession _chat;

  const AiChatDataSourceImpl(
    ChatSession chat,
  ): _chat = chat;

  @override
  Stream<String> callAiChat(String message) async* {
    final response = _chat.sendMessageStream(Content.text(message));

     await for(var chunk in response) {
       final text = chunk.text;

       if(text != null) yield text;
     }
  }
}