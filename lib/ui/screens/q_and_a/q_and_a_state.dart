import 'package:ai_player_a/data/model/chat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'q_and_a_state.freezed.dart';

@freezed
class QAndAState with _$QAndAState{
  const QAndAState._();
  const factory QAndAState({
    @Default([])
    List<Chat> chatList,
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
    Chat chat;
    List<Chat> newChatList;

    if(authors == Authors.user) {
      chat = _createUserChat(message);
      newChatList = [...chatList, chat];
    } else {
      chat = _createAiChat(message);
      newChatList = _createAiChatList(chat);
    }

    return copyWith(chatList: newChatList);
  }

  Chat _createUserChat(String message) {
    return Chat(
      author: Authors.user,
      message: message,
    );
  }

  Chat _createAiChat(String message) {
    final lastChat = chatList.last;

    return (lastChat.author == Authors.user) ?
      Chat(author: Authors.ai, message: message) :
      Chat(author: Authors.ai, message: lastChat.message + message);
  }

  List<Chat> _createAiChatList(Chat chat) {
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
