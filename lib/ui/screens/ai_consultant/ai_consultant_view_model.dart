import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'ai_consultant_view_model.g.dart';

@riverpod
class AiConsultantViewModel extends _$AiConsultantViewModel {
  @override
  FutureOr<AiConsultantState> build() async {
    final repository = ref.read(aiChatRepositoryProvider);
    final response = await repository.initChat();

    final tts = ref.read(textToSpeechUseCaseProvider);
    tts.speak(response);

    final textMessage = TextMessage(
      author: getAiUser(),
      id: const Uuid().v4(),
      text: response,
    );

    return AiConsultantState(
      messages: [textMessage],
    );
  }

  User getUser() {
    return const User(id: 'user');
  }

  User getAiUser() {
    return const User(id: 'ai');
  }

  void _updateState({
    List<Message>? messages,
    bool? isConnecting,
  }) {
    if(state.value == null) return;
    AiConsultantState stateValue = state.value!;

    if(messages != null) stateValue = stateValue.copyWith(messages: messages);
    if(isConnecting != null) stateValue = stateValue.copyWith(isConnecting: isConnecting);

    state = AsyncData(stateValue);
  }

  Future<void> sendMessage(PartialText message) async {
    if(state.value == null) return;
    AiConsultantState stateValue = state.value!;

    final textMessage = TextMessage(
      author: getUser(),
      id: const Uuid().v4(),
      text: message.text,
    );
    _updateState(
      messages: [textMessage, ...stateValue.messages],
      isConnecting: true,
    );

    final repository = ref.read(aiChatRepositoryProvider);
    repository.callAiChat(message.text)
      .listen(_onData)
      ..onError((handleError){
        _updateState(isConnecting: false);
        state = AsyncError(handleError, StackTrace.current);
      })
      ..onDone(_onDone);
  }

  void _onData(String message) {
    if(state.value == null) return;
    AiConsultantState stateValue = state.value!;

    final textMessage = TextMessage(
      author: getAiUser(),
      id: const Uuid().v4(),
      text: message,
    );
    _updateState(messages: [textMessage, ...stateValue.messages]);
  }

  void _onDone() {
    _updateState(isConnecting: false);
  }
}
