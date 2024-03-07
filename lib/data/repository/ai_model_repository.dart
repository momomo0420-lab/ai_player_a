import 'dart:typed_data';

import 'package:ai_player_a/data/model/chat_model.dart';

abstract class AiModelRepository {
  Stream<String> callAiChat({
    required List<ChatModel> history,
    required String message,
  });

  Future<String> initConsultation();
  Stream<String> consultSymptom({
    required List<ChatModel> history,
    required String message,
  });

  Stream<String> checkWaitingTile(Uint8List image);
}