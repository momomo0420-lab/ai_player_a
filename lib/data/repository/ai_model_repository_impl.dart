import 'dart:typed_data';

import 'package:ai_player_a/data/data_source/ai_chat_data_source.dart';
import 'package:ai_player_a/data/data_source/symptom_consultant_data_source.dart';
import 'package:ai_player_a/data/data_source/waiting_tile_checker_data_source.dart';
import 'package:ai_player_a/data/model/message_model.dart';
import 'package:ai_player_a/data/repository/ai_model_repository.dart';

class AiModelRepositoryImpl implements AiModelRepository {
  final AiChatDataSource _aiChatDataSource;
  final SymptomConsultantDataSource _symptomConsultantDataSource;
  final WaitingTileCheckerDataSource _waitingTileCheckerDataSource;


  const AiModelRepositoryImpl({
    required AiChatDataSource aiChatDataSource,
    required SymptomConsultantDataSource symptomConsultantDataSource,
    required WaitingTileCheckerDataSource waitingTileCheckerDataSource,
  }): _aiChatDataSource = aiChatDataSource,
        _symptomConsultantDataSource = symptomConsultantDataSource,
        _waitingTileCheckerDataSource = waitingTileCheckerDataSource;

  @override
  Stream<String> callAiChat({
    required List<MessageModel> history,
    required String message,
  }) {
    return _aiChatDataSource.call(history: history, message: message);
  }

  @override
  Future<String> initConsultation() async {
    return await _symptomConsultantDataSource.init();
  }

  @override
  Stream<String> consultSymptom({
    required List<MessageModel> history,
    required String message,
  }) {
    return _symptomConsultantDataSource.consult(
      history: history,
      message: message,
    );
  }

  @override
  Stream<String> checkWaitingTile(Uint8List image) {
    return _waitingTileCheckerDataSource.check(image);
  }
}