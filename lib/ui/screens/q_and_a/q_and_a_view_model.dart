import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/data/model/chat.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_state.dart';
import 'package:ai_player_a/ui/widget/one_line_text_field.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q_and_a_view_model.g.dart';

@riverpod
class QAndAViewModel extends _$QAndAViewModel {
  @override
  FutureOr<QAndAState> build() async {
    const message = 'こんにちは\nご用件はなんでしょうか？';

    final tts = ref.read(textToSpeechUseCaseProvider);
    tts.speak(message);

    const chat = Chat(author: Authors.ai, message: message);
    return const QAndAState(
      chatList: [chat],
    );
  }

  void _updateState({
    Authors? authors,
    String? message,
    bool? isLoading,
    bool? isRecording,
    bool? isEmptyWithTextField,
  }) {
    if(state.value == null) {
      state = AsyncError('予期せぬエラーが発生しました。', StackTrace.current);
      return;
    }
    QAndAState stateValue = state.value!;

    if((authors != null) && (message != null)) {
      stateValue = stateValue.addChat(authors, message);
    }
    if(isLoading != null) {
      stateValue = stateValue.copyWith(isLoading: isLoading);
    }
    if(isRecording != null) {
      stateValue = stateValue.copyWith(isRecording: isRecording);
    }
    if(isEmptyWithTextField != null) {
      stateValue = stateValue.copyWith(isEmptyWithTextField: isEmptyWithTextField);
    }

    state = AsyncData(stateValue);
  }

  SendButtonState isSendButtonState() {
    if(state.value == null) return SendButtonState.isLoading;
    final stateValue = state.value!;

    if(stateValue.isLoading) return SendButtonState.isLoading;
    if(stateValue.isRecording) return SendButtonState.isRecording;
    if(stateValue.isEmptyWithTextField) return SendButtonState.isWaitingRec;

    return SendButtonState.isWaitingText;
  }

  Future<void> changeTextField(String message) async {
    final isEmpty = (message == '');
    _updateState(isEmptyWithTextField: isEmpty);
  }

  Future<void> callAiChat(String message) async {
    _updateState(
      authors: Authors.user,
      message: message,
      isLoading: true,
      isEmptyWithTextField: true,
    );

    final repository = ref.read(aiChatRepositoryProvider);
    final response = repository.callAiChat(message);
    response.listen((chunk) {
      _updateState(authors: Authors.ai, message: chunk);
    })
    ..onError((handleError) {
      state = AsyncError(handleError, StackTrace.current);
    })
    ..onDone(() {
      // final tts = ref.read(textToSpeechUseCaseProvider);
      //
      // if(state.value == null) return;
      // final newStateValue = state.value!;
      // tts.speak(newStateValue.chatList.last.message);
      _updateState(isLoading: false);
    });
  }

  Future<void> startListening() async {
    _updateState(isRecording: true);

    final stt = ref.read(speechToTextUseCaseProvider);
    await stt.listen((message) {
      if(state.value == null) return;
      final stateValue = state.value!;

      if(message == '' || (stateValue.isLoading == true)) return;

      callAiChat(message);
      state = AsyncData(stateValue.copyWith(isRecording: false));
    });
  }

  Future<void> stopListening() async {
    final stt = ref.read(speechToTextUseCaseProvider);
    await stt.stop();

    _updateState(isRecording: false);
  }
}
