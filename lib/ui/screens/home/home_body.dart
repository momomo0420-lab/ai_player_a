import 'package:ai_player_a/ui/widget/menu_card.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final Function()? _navigateNextScreen;

  const HomeBody({
    super.key,
    Function()? navigateNextScreen,
  }): _navigateNextScreen = navigateNextScreen;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          menuCard(
            Image.asset('images/kusuribako.png'),
            'title',
            'description',
            'START',
            _navigateNextScreen,
          ),
        ],
      ),
    );
  }
}
