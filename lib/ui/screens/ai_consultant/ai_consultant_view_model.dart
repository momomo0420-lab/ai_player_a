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

  Future<TextMessage> _buildUserTextMessage(String text) async {
    return TextMessage(
      author: getUser(),
      id: const Uuid().v4(),
      text: text,
    );
  }

  Future<TextMessage> _buildAiTextMessage(String text) async {
    final currentState = await future;

    String messageText = "";
    final latestMessage = currentState.messages.first as TextMessage;
    if(latestMessage.author == getAiUser()) {
      messageText = latestMessage.text;
    }
    messageText += text;

    return TextMessage(
      author: getAiUser(),
      id: const Uuid().v4(),
      text: messageText,
    );
  }

  Future<void> sendMessage(PartialText message) async {
    state = await AsyncValue.guard(() async {
      final textMessage = await _buildUserTextMessage(message.text);

      final currentState = await future;
      return currentState.copyWith(
        messages: [textMessage, ...currentState.messages],
        isConnecting: true,
      );
    });

    final repository = ref.read(aiChatRepositoryProvider);
    repository.callAiChat(message.text)
      .listen(_onData)
      ..onError(_onError)
      ..onDone(_onDone);
  }

  Future<void> _onData(String message) async {
    final currentState = await future;

    // Stream型の為、前回がAIから取得したメッセージの場合は前回のデータを削除し、
    // 新しいメッセージで更新する。
    var messages = [...currentState.messages];
    final latestMessage = currentState.messages.first;
    if(latestMessage.author == getAiUser()) {
      messages.removeAt(0);
    }
    final textMessage = await _buildAiTextMessage(message);
    messages.insert(0, textMessage);

    state = await AsyncValue.guard(() async {
      return currentState.copyWith(messages: messages);
    });
  }

  Future<void> _onError(Object handleError) async {
    state = AsyncError(handleError, StackTrace.current);
  }

  Future<void> _onDone() async {
    state = await AsyncValue.guard(() async {
      final currentState = await future;
      return currentState.copyWith(isConnecting: false);
    });
  }
}
