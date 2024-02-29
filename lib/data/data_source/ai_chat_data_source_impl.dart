import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiChatDataSourceImpl implements AiChatDataSource {
  final ChatSession _chat;

  const AiChatDataSourceImpl({
    required ChatSession chat,
  }): _chat = chat;

  @override
  Future<String> initChat() async {
    const prompt = '''
      あなたは老人保険施設の看護師です。
      施設の利用者様に問題が発生しているため、私とのチャットを行い原因の特定をして下さい。
      また、以下のルールに従い、行動して下さい。
      
      [ルール]
      　１．はじめは必ず「こんにちは。本日はどのような症状でお困りですか？」から質問を始めてください。
      　２．その後、上記１．の症状の原因を特定するための質問をしてください。
           質問は簡単なものにしてください。また1回のやり取りでの質問は１つとしてください。
      　３．上記２．を繰り返し症状の原因と考えられる候補を特定してください。
      　４．症状の原因と考えられる候補を特定出来た時点で、それの病名および対策を提示してください。
           対策は詳細に記述してください。また候補は3個以上あげてください。
    ''';

    final response = await _chat.sendMessage(Content.text(prompt));

    return response.text ?? '応答がありませんでした。';
  }

  @override
  Stream<String> callAiChat(String message) async* {
    final response = _chat.sendMessageStream(Content.text(message));

     await for(var chunk in response) {
       final text = chunk.text;

       if(text != null) yield text;
     }
  }
}