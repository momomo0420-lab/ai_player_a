import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q_and_a_view_model.g.dart';

enum Authors {
  ai,
  user;
}

@riverpod
class QAndAViewModel extends _$QAndAViewModel {
  @override
  FutureOr<QAndAState> build() async {
    const message = 'こんにちは＾＾\n'
      + 'ご用件はなんでしょうか？';
    final chat = Chat(author: Authors.ai.name, message: message);

    return QAndAState(
      chatList: [chat],
    );
  }

  void setChat(String author, String message) {
    if(state.value == null) return;

    final stateValue = state.value!;
    final chat = Chat(author: author, message: message);
    final newChatList = [...stateValue.chatList, chat];

    final newStateValue = stateValue.copyWith(
      chatList: newChatList,
    );

    state = AsyncData(newStateValue);
  }

  void setLoading(bool isLoading) {
    if(state.value == null) return;

    final stateValue = state.value!;
    final newStateValue = stateValue.copyWith(isLoading: isLoading);
    state = AsyncData(newStateValue);
  }

  void setSendable(bool isSendable) {
    if(state.value == null) return;

    final stateValue = state.value!;
    if(isSendable == stateValue.isSendable) return;

    final newStateValue = stateValue.copyWith(isSendable: isSendable);
    state = AsyncData(newStateValue);
  }

  Future<void> callAiChat(String sendMessage) async {
    setChat(Authors.user.name, sendMessage);
    setLoading(true);

    final repository = ref.read(aiChatRepositoryProvider);
    final stream = repository.callAiChat2(sendMessage);
    stream.listen((response) {
      setChat(Authors.ai.name, response);
    })
    ..onError((handleError) {
      setLoading(false);
      state = AsyncError(handleError, StackTrace.current);
    })
    ..onDone(() {
      setLoading(false);
    });
  }
}
