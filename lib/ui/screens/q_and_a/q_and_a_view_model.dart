import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q_and_a_view_model.g.dart';

@riverpod
class QAndAViewModel extends _$QAndAViewModel {
  @override
  FutureOr<QAndAState> build() async {
    return const QAndAState();
  }

  void setChat(String author, String message) {
    if(state.value == null) return;
    QAndAState stateValue = state.value!;

    final chat = Chat(author: author, message: message);
    final newChatList = [...stateValue.chatList, chat];

    stateValue = stateValue.copyWith(
      chatList: newChatList,
    );

    state = AsyncData(stateValue);
  }

  void setLoading(bool isLoading) {
    if(state.value == null) return;
    QAndAState stateValue = state.value!;

    stateValue = stateValue.copyWith(isLoading: isLoading);
    state = AsyncData(stateValue);
  }

  Future<void> callAiChat(String sendMessage) async {
    setChat('user', sendMessage);
    setLoading(true);

    final repository = ref.read(aiChatRepositoryProvider);
    final recvMessage = await repository.callAiChat(sendMessage);

    setChat('ai', recvMessage);
    setLoading(false);
  }
}
