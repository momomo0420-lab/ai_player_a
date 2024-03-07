import 'package:ai_player_a/data/model/chat_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'q_and_a_state.freezed.dart';

@freezed
class QAndAState with _$QAndAState{
  const QAndAState._();
  const factory QAndAState({
    @Default([])
    List<ChatModel> chatList,
    @Default(false)
    bool isLoading,
    @Default(false)
    bool isRecording,
    @Default(true)
    bool isEmptyWithTextField,
  }) = _QAndAState;

  QAndAState addChat(
    Authors authors,
    String message,
  ) {
    ChatModel chat;
    List<ChatModel> newChatList;

    if(authors == Authors.user) {
      chat = _createUserChat(message);
      newChatList = [...chatList, chat];
    } else {
      chat = _createAiChat(message);
      newChatList = _createAiChatList(chat);
    }

    return copyWith(chatList: newChatList);
  }

  ChatModel _createUserChat(String message) {
    return ChatModel(
      author: Authors.user,
      message: message,
    );
  }

  ChatModel _createAiChat(String message) {
    final lastChat = chatList.last;

    return (lastChat.author == Authors.user) ?
    ChatModel(author: Authors.ai, message: message) :
    ChatModel(author: Authors.ai, message: lastChat.message + message);
  }

  List<ChatModel> _createAiChatList(ChatModel chat) {
    final oldChatList = [...chatList];
    final lastChat = oldChatList.last;

    if(lastChat.author == Authors.user) {
      oldChatList.add(chat);
    } else {
      oldChatList[oldChatList.length - 1] = chat;
    }

    return oldChatList;
  }
}
