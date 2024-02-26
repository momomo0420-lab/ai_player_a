import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_screen.dart';
import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_screen.dart';
import 'package:ai_player_a/ui/screens/home/home_screen.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppScreens {
  home('/'),
  qAndA('/q_and_a'),
  aiChat('/ai_chat'),
  aiConsultant('/ai_consultant'),
  ;

  final String path;

  const AppScreens(this.path);
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AIお試しアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _buildGoRouter(),
    );
  }

  GoRouter _buildGoRouter() {
    return GoRouter(
      initialLocation: AppScreens.home.path,
      routes: [
        GoRoute(
          path: AppScreens.home.path,
          builder: _buildHomeScreen,
        ),

        GoRoute(
          path: AppScreens.qAndA.path,
          builder: _buildQAndAScreen,
        ),

        GoRoute(
          path: AppScreens.aiChat.path,
          builder: _buildAiChatScreen,
        ),

        GoRoute(
          path: AppScreens.aiConsultant.path,
          builder: _buildAiConsultant,
        )
      ],
    );
  }

  Widget _buildHomeScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return HomeScreen(
      navigateQAndA: () => context.push(AppScreens.qAndA.path),
      navigateAiChat: () => context.push(AppScreens.aiChat.path),
      navigateAiConsultant: () => context.push(AppScreens.aiConsultant.path),
    );
  }

  Widget _buildAiChatScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return const AiChatScreen();
  }

  Widget _buildQAndAScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return const QAndAScreen();
  }

  Widget _buildAiConsultant(
    BuildContext context,
    GoRouterState state
  ) {
    return const AiConsultantScreen();
  }
}
