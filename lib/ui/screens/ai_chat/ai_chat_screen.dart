import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_body.dart';
import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_state.dart';
import 'package:ai_player_a/ui/screens/ai_chat/ai_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiChatScreen extends ConsumerWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiChatViewModelProvider);
    final viewModel = ref.watch(aiChatViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AIチャット'),
      ),

      backgroundColor: Colors.lightBlue,

      body: state.when(
        data: (stateValue) => _onSuccess(stateValue, viewModel),
        error: _onError,
        loading: _onLoad,
      ),
    );
  }

  Widget _onSuccess(
    AiChatState state,
    AiChatViewModel viewModel,
  ) {
    return AiChatBody(state: state, viewModel: viewModel);
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return const Center(child: Text('原因不明のエラーが発生しました。'));
  }

  Widget _onLoad() => const Center(child: CircularProgressIndicator());
}
