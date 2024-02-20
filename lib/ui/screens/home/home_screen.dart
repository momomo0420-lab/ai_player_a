import 'package:ai_player_a/ui/screens/home/home_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function()? _navigateQAndAScreen;
  final Function()? _navigateAiChatScreen;

  const HomeScreen({
    super.key,
    Function()? navigateQAndAScreen,
    Function()? navigateAiChatScree,
  }): _navigateQAndAScreen = navigateQAndAScreen,
        _navigateAiChatScreen = navigateAiChatScree;

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
          navigateQAndAScreen: _navigateQAndAScreen,
          navigateAiChatScreen: _navigateAiChatScreen,
        ),
      ),
    );
  }
}
