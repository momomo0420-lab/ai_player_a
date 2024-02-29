import 'dart:io';

import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_state.dart';
import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_view_model.dart';
import 'package:flutter/material.dart';

class WaitingTileCheckerBody extends StatelessWidget {
  final WaitingTileCheckerState _state;
  final WaitingTileCheckerViewModel _viewModel;

  const WaitingTileCheckerBody({
    super.key,
    required WaitingTileCheckerState state,
    required WaitingTileCheckerViewModel viewModel,
  }): _state = state,
        _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image.file(File(_state.path)),
            Text(_state.response),
          ],
        ),

        Center(
          child: _buildIndicator(),
        )
      ],
    );
  }

  Widget _buildIndicator() {
    Widget widget;

    if(_state.isConnecting) {
      widget = const CircularProgressIndicator();
    } else {
      widget = Container();
    }

    return widget;
  }
}
