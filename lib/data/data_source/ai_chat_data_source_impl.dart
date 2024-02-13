import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AiChatDataSourceImpl implements AiChatDataSource {
  final Gemini _gemini;

  const AiChatDataSourceImpl(
    Gemini gemini,
  ): _gemini = gemini;

  @override
  Stream<String> callAiChat(String message) async* {
     final stream = _gemini.streamGenerateContent(message);

     await for(var value in stream) {
       final response = value.output;

       if(response != null) yield response;
     }
  }

  @override
  Future<String> callAiChat2(String message) async {
    final response = await _gemini.text(message);

    return response?.output ?? '';
  }
}