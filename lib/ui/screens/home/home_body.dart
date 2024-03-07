import 'package:ai_player_a/ui/widget/menu_card.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final Function()? _navigateQAndA;
  final Function()? _navigateAiChat;
  final Function()? _navigateAiConsultant;
  final Function()? _navigateWaitingTileChecker;

  const HomeBody({
    super.key,
    Function()? navigateQAndA,
    Function()? navigateAiChat,
    Function()? navigateAiConsultant,
    Function()? navigateWaitingTileChecker,
  }): _navigateQAndA = navigateQAndA,
        _navigateAiChat = navigateAiChat,
        _navigateAiConsultant = navigateAiConsultant,
        _navigateWaitingTileChecker = navigateWaitingTileChecker;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          menuCard(
            Image.asset('images/ai_chat.png'),
            'AIチャット',
            'AIとの対話を行います。',
            'START',
            _navigateAiChat,
          ),
          const SizedBox(height: 20,),

          menuCard(
            Image.asset('images/kusuribako.png'),
            '症状診断',
            '対話形式で症状の診断を行います。',
            'START',
            _navigateAiConsultant,
          ),
          const SizedBox(height: 20,),

          menuCard(
            Image.asset('images/ma-jan_pai.png'),
            '待ち牌チェッカー',
            '手牌の画像から待ち牌を回答します。',
            'START',
            _navigateWaitingTileChecker,
          ),
        ],
      ),
    );
  }
}
