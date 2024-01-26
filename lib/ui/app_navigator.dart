import 'package:ai_player_a/ui/screens/home/home_screen.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppScreens {
  home('/'),
  q_and_a('/q_and_a'),
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
          path: AppScreens.q_and_a.path,
          builder: _buildQAndAScreen,
        ),
      ],
    );
  }

  Widget _buildHomeScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return HomeScreen(
      navigateNextScreen: () => context.push(AppScreens.q_and_a.path),
    );
  }

  Widget _buildQAndAScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return const QAndAScreen();
  }
}
