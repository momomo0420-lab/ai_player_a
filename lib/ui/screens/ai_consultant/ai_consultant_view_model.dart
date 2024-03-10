import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/data/model/message_model.dart';
import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_consultant_view_model.g.dart';

@riverpod
class AiConsultantViewModel extends _$AiConsultantViewModel {
  @override
  FutureOr<AiConsultantState> build() async {
    final repository = ref.read(aiModelRepositoryProvider);
    final message = await repository.initConsultation();

    return AiConsultantState(
      history: [MessageModel(author: Authors.ai, message: message)],
    );
  }

  Future<AiConsultantState> _updateState({
    bool? isConnecting,
    List<MessageModel>? history,
  }) async {
    state = await AsyncValue.guard(() async {
      final currentState = await future;

      return currentState.copyWith(
        isConnecting: isConnecting ?? currentState.isConnecting,
        history: history ?? currentState.history,
      );
    });

    return await future;
  }

  Future<void> sendMessage(String message) async {
    final currentState = await _updateState(isConnecting: true);
    final repository = ref.read(aiModelRepositoryProvider);
    final response = repository.consultSymptom(
      history: currentState.history,
      message: message,
    );

    final chat = MessageModel(author: Authors.user, message: message);
    final history = [...currentState.history];
    history.add(chat);
    _updateState(history: history);

    response.listen(
      _onData,
      onError: _onError,
      onDone: _onDone,
    );
  }

  Future<void> _onData(String chunk) async {
    final currentState = await future;
    final history = [...currentState.history];

    String message = '';

    final latestChat = history.last;
    if(latestChat.author == Authors.ai) {
      final removedChat = history.removeLast();
      message = removedChat.message;
    }

    final newAiChat = MessageModel(
      author: Authors.ai,
      message: message + chunk,
    );
    history.add(newAiChat);

    _updateState(history: history);
  }

  Future<void> _onError(Object error) async {
    state = AsyncError(error, StackTrace.current);
  }

  Future<void> _onDone() async {
    _updateState(isConnecting: false);
  }
}
