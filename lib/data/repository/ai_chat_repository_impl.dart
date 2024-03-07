import 'dart:typed_data';

import 'package:ai_player_a/data/model/chat_model.dart';
import 'package:ai_player_a/data/repository/ai_chat_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final GenerativeModel _model;

  const AiChatRepositoryImpl({
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

  @override
  Future<String> initConsultation() async {
    return 'こんにちは。本日はどのような症状でお困りですか？';
  }

  @override
  Stream<String> consultSymptom({
    required List<ChatModel> history,
    required String message,
  }) async* {
    List<Content> historyContents = [
      Content.text(_initialUserPrompt),
    ];
    historyContents += _buildHistoryContents(history);
    final chat = _model.startChat(
      history: historyContents,
    );
    final response = chat.sendMessageStream(Content.text(message));

    await for(var chunk in response) {
      final text = chunk.text;

      if(text != null) yield text;
    }
  }

  String get _initialUserPrompt => '''
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

  @override
  Stream<String> checkWaitingTile(Uint8List image) async* {
    const prompt = '''
      あなたはプロの雀士です。
      次の画像を確認し、待ち牌を回答してください。
      またテンパイしていない場合は「まだテンパイしていません。」と回答してください。
      また画像から判断できない場合は「判断できない画像です。」と回答してください。
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