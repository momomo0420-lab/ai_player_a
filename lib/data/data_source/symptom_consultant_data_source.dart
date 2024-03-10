import 'package:ai_player_a/data/model/message_model.dart';

abstract class SymptomConsultantDataSource {
  Future<String> init();
  Stream<String> consult({
    required List<MessageModel> history,
    required String message,
  });
}