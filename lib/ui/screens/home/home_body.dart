import 'package:ai_player_a/ui/widget/menu_card.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final Function()? _navigateQAndAScreen;
  final Function()? _navigateAiChatScreen;

  const HomeBody({
    super.key,
    Function()? navigateQAndAScreen,
    Function()? navigateAiChatScreen,
  }): _navigateQAndAScreen = navigateQAndAScreen,
        _navigateAiChatScreen = navigateAiChatScreen;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          menuCard(
            Image.asset('images/kusuribako.png'),
            '症状診断',
            '対話形式で症状の診断を行います。',
            'START',
            _navigateQAndAScreen,
          ),
          const SizedBox(height: 20,),

          menuCard(
            Image.asset('images/ai_chat.png'),
            'AIチャット',
            'AIとのチャットを開始します。',
            'START',
            _navigateAiChatScreen,
          ),
        ],
      ),
    );
  }
}
