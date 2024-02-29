import 'package:freezed_annotation/freezed_annotation.dart';

part 'waiting_tile_checker_state.freezed.dart';

@freezed
class WaitingTileCheckerState with _$WaitingTileCheckerState {
  const factory WaitingTileCheckerState({
    @Default('')
    String path,
    @Default('')
    String response,
    @Default(false)
    bool isConnecting,
  }) = _WaitingTileCheckerState;
}