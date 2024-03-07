import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_screen.dart';
import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_screen.dart';
import 'package:ai_player_a/ui/screens/home/home_screen.dart';
import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppScreens {
  home('/'),
  aiChat('/ai_chat'),
  aiConsultant('/ai_consultant'),
  waitingTileChecker('/waiting_tile_checker'),
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
          path: AppScreens.aiChat.path,
          builder: _buildAiChatScreen,
        ),

        GoRoute(
          path: AppScreens.aiConsultant.path,
          builder: _buildAiConsultant,
        ),

        GoRoute(
          path: AppScreens.waitingTileChecker.path,
          builder: _buildWaitingTileChecker,
        ),
      ],
    );
  }

  Widget _buildHomeScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return HomeScreen(
      navigateAiChat: () => context.push(AppScreens.aiChat.path),
      navigateAiConsultant: () => context.push(AppScreens.aiConsultant.path),
      navigateWaitingTileChecker: () => context.push(AppScreens.waitingTileChecker.path),
    );
  }

  Widget _buildAiChatScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return const AiChatScreen();
  }

  Widget _buildAiConsultant(
    BuildContext context,
    GoRouterState state
  ) {
    return const AiConsultantScreen();
  }

  Widget _buildWaitingTileChecker(
    BuildContext context,
    GoRouterState state,
  ) {
    return const WaitingTileCheckerScreen();
  }
}
