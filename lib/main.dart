import 'package:ai_player_a/common/env.dart';
import 'package:ai_player_a/ui/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  Gemini.init(apiKey: Env.geminiApiKey);

  runApp(
    const ProviderScope(
      child: AppNavigator(),
    ),
  );
}
