import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiChatDataSourceImpl implements AiChatDataSource {
  final GenerativeModel _model;

  const AiChatDataSourceImpl(
      GenerativeModel model,
  ): _model = model;

  @override
  Stream<String> callAiChat(String message) async* {
    final response = _model.generateContentStream(
      createPrompt(message),
    );

     await for(var chunk in response) {
       final text = chunk.text;

       if(text != null) yield text;
     }
  }

  @override
  Future<String> callAiChat2(String message) async {
    final response = await _model.generateContent(
      createPrompt(message),
    );

    return response.text ?? '応答がありません。';
  }

  Iterable<Content> createPrompt(String message) {
    return [Content.text(message)];
  }
}