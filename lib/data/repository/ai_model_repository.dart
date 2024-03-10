import 'dart:typed_data';

import 'package:ai_player_a/data/model/message_model.dart';

abstract class AiModelRepository {
  Stream<String> callAiChat({
    required List<MessageModel> history,
    required String message,
  });

  Future<String> initConsultation();
  Stream<String> consultSymptom({
    required List<MessageModel> history,
    required String message,
  });

  Stream<String> checkWaitingTile(Uint8List image);
}