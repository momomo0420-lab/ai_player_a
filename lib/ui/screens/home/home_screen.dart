import 'package:ai_player_a/ui/screens/home/home_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function()? _navigateQAndA;
  final Function()? _navigateAiChat;
  final Function()? _navigateAiConsultant;

  const HomeScreen({
    super.key,
    Function()? navigateQAndA,
    Function()? navigateAiChat,
    Function()? navigateAiConsultant,
  }): _navigateQAndA = navigateQAndA,
        _navigateAiChat = navigateAiChat,
        _navigateAiConsultant = navigateAiConsultant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AIお試し用のアプリ'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HomeBody(
          navigateQAndA: _navigateQAndA,
          navigateAiChat: _navigateAiChat,
          navigateAiConsultant: _navigateAiConsultant,
        ),
      ),
    );
  }
}
