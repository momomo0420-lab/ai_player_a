import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_body.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_state.dart';
import 'package:ai_player_a/ui/screens/q_and_a/q_and_a_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QAndAScreen extends ConsumerWidget {
  const QAndAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qAndAViewModelProvider);
    final viewModel = ref.watch(qAndAViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('症状の相談'),
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
    QAndAState state,
    QAndAViewModel viewModel,
  ) {
    return QAndABody(state: state, viewModel: viewModel);
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return const Center(child: Text('原因不明のエラーが発生しました。'));
  }

  Widget _onLoad() => const Center(child: CircularProgressIndicator());
}
