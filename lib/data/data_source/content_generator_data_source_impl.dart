import 'dart:typed_data';

import 'package:ai_player_a/data/data_source/content_generator_data_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ContentGeneratorDataSourceImpl implements ContentGeneratorDataSource {
  final GenerativeModel _model;

  const ContentGeneratorDataSourceImpl({
    required GenerativeModel model,
  }): _model = model;

  @override
  Stream<String> listenWaitingTile(Uint8List image) async* {
    const prompt = '''
      あなたはプロの雀士です。
      次の画像を確認し、待ち牌を回答してください。
      またテンパイしていない場合は「まだテンパイしていません。」と回答してください。
    ''';

    final promptPart = TextPart(prompt);
    final imagePart = DataPart('image/jpeg', image);
    final parts = [promptPart, imagePart];

    final contents = [Content.multi(parts)];
    final response = _model.generateContentStream(contents);

    await for(var chunk in response) {
      final text = chunk.text;

      if(text != null) yield text;
    }
  }
}