import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_state.dart';
import 'package:ai_player_a/ui/widget/one_line_text_field.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q_and_a_view_model.g.dart';

@riverpod
class QAndAViewModel extends _$QAndAViewModel {
  @override
  FutureOr<QAndAState> build() async {
    const message = 'こんにちは\n'
      + 'ご用件はなんでしょうか？';
    final tts = ref.read(textToSpeechUseCaseProvider);
    tts.speak(message);

    const chat = Chat(author: Authors.ai, message: message);
    return const QAndAState(
      chatList: [chat],
    );
  }

  void setUserChat(String message) {
    if(state.value == null) return;
    final stateValue = state.value!;

    final chat = Chat(author: Authors.user, message: message);
    final newChatList = [...stateValue.chatList, chat];

    final newStateValue = stateValue.copyWith(
      chatList: newChatList,
    );

    state = AsyncData(newStateValue);
  }

  void setAiChat(String message) {
    if(state.value == null) return;
    final stateValue = state.value!;

    final chatList = [...stateValue.chatList];
    final lastChat = chatList.last;

    if(lastChat.author == Authors.user) {
      chatList.add(
        Chat(author: Authors.ai, message: message),
      );
    } else {
      final newChat = Chat(
        author: Authors.ai,
        message: lastChat.message + message
      );
      chatList[chatList.length - 1] = newChat;
    }

    final newStateValue = stateValue.copyWith(
      chatList: chatList,
    );
    state = AsyncData(newStateValue);
  }

  void setLoading(bool isLoading) {
    if(state.value == null) return;
    final stateValue = state.value!;

    final newStateValue = stateValue.copyWith(isLoading: isLoading);
    state = AsyncData(newStateValue);
  }

  void setEmptyWithTextField(bool isEmpty) {
    if(state.value == null) return;
    final stateValue = state.value!;

    if(isEmpty == stateValue.isEmptyWithTextField) return;

    final newStateValue = stateValue.copyWith(isEmptyWithTextField: isEmpty);
    state = AsyncData(newStateValue);
  }

  void setRecording(bool isRecording) {
    if(state.value == null) return;
    final stateValue = state.value!;

    final newStateValue = stateValue.copyWith(isRecording: isRecording);
    state = AsyncData(newStateValue);
  }

  SendButtonState isSendButtonState() {
    if(state.value == null) return SendButtonState.isLoading;
    final stateValue = state.value!;

    if(stateValue.isLoading) return SendButtonState.isLoading;
    if(stateValue.isRecording) return SendButtonState.isRecording;
    if(stateValue.isEmptyWithTextField) return SendButtonState.isWaitingRec;

    return SendButtonState.isWaitingText;
  }

  Future<void> callAiChat(String sendMessage) async {
    setUserChat(sendMessage);
    setLoading(true);

    final repository = ref.read(aiChatRepositoryProvider);
    final stream = repository.callAiChat(sendMessage);
    stream.listen((response) {
      // final tts = ref.read(textToSpeechUseCaseProvider);
      // tts.speak(response);
      setAiChat(response);
    })
    ..onError((handleError) {
      setLoading(false);
      state = AsyncError(handleError, StackTrace.current);
    })
    ..onDone(() {
      setLoading(false);
    });
  }

  Future<void> callAiChat2(String sendMessage) async {
    setUserChat(sendMessage);
    setLoading(true);

    final repository = ref.read(aiChatRepositoryProvider);
    final response = await repository.callAiChat2(sendMessage);
    final tts = ref.read(textToSpeechUseCaseProvider);
    tts.speak(response);

    setAiChat(response);
    setLoading(false);
  }
}
