import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/data/model/chat_model.dart';
import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_chat_view_model.g.dart';

@riverpod
class AiChatViewModel extends _$AiChatViewModel {
  @override
  FutureOr<AiChatState> build() async {
    return const AiChatState();
  }

  Future<AiChatState> _updateState({
    bool? isConnecting,
    List<ChatModel>? history,
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
    final repository = ref.read(aiChatRepositoryProvider);
    final response = repository.callAiChat(
      history: currentState.history,
      message: message,
    );

    final chat = ChatModel(author: Authors.user, message: message);
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

    final newAiChat = ChatModel(
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
