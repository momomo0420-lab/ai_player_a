import 'package:ai_player_a/ui/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppNavigator(),
    ),
  );
}
