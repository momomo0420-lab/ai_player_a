import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_body.dart';
import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_state.dart';
import 'package:ai_player_a/ui/screens/ai_consultant/ai_consultant_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiConsultantScreen extends ConsumerWidget {
  const AiConsultantScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiConsultantViewModelProvider);
    final viewModel = ref.watch(aiConsultantViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AIコンサルタント'),
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
    AiConsultantState state,
    AiConsultantViewModel viewModel,
  ) {
    return AiConsultantBody(state: state, viewModel: viewModel);
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return const Center(child: Text('原因不明のエラーが発生しました。'));
  }

  Widget _onLoad() => const Center(child: CircularProgressIndicator());
}
