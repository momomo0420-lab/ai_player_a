import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_body.dart';
import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_state.dart';
import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingTileCheckerScreen extends ConsumerWidget {
  const WaitingTileCheckerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(waitingTileCheckerViewModelProvider);
    final viewModel = ref.watch(waitingTileCheckerViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('待ち牌チェッカー'),
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
    WaitingTileCheckerState state,
    WaitingTileCheckerViewModel viewModel,
  ) {
    return WaitingTileCheckerBody(state: state, viewModel: viewModel);
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return const Center(child: Text('原因不明のエラーが発生しました。'));
  }

  Widget _onLoad() => const Center(child: CircularProgressIndicator());
}
