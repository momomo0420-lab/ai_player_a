import 'dart:typed_data';

import 'package:ai_player_a/data/data_source/waiting_tile_checker_data_source.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class WaitingTileCheckerDataSourceImpl implements WaitingTileCheckerDataSource {
  final GenerativeModel _model;

  const WaitingTileCheckerDataSourceImpl(
    GenerativeModel model,
  ): _model = model;

  @override
  Stream<String> check(
      Uint8List image,
  ) async* {
    const textPrompt = '''
      あなたはプロの雀士です。
      次の画像を確認し、待ち牌を回答してください。
      またテンパイしていない場合は「まだテンパイしていません。」と回答してください。
      また画像から判断できない場合は「判断できない画像です。」と回答してください。
    ''';

    final promptPart = TextPart(textPrompt);
    final imagePart = DataPart('image/jpeg', image);
    final parts = [promptPart, imagePart];

    final prompt = [Content.multi(parts)];

    final response = _model.generateContentStream(prompt);

    await for(var chunk in response) {
      final text = chunk.text;

      if(text != null) yield text;
    }
  }
}