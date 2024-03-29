import 'package:ai_player_a/app_container.dart';
import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'waiting_tile_checker_view_model.g.dart';

@riverpod
class WaitingTileCheckerViewModel extends _$WaitingTileCheckerViewModel {
  @override
  FutureOr<WaitingTileCheckerState> build() async {
    final imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if(xFile == null) throw Exception('Error: 画像が取得できませんでした。');

    final repository = ref.read(aiModelRepositoryProvider);
    final byteData = await xFile.readAsBytes();
    final response = repository.checkWaitingTile(byteData);

    response.listen(_onData,
      onDone: _onDone,
      onError: _onError,
    );

    return WaitingTileCheckerState(path: xFile.path, isConnecting: true);
  }

  Future<void> retry() async {
    ref.invalidateSelf();
  }

  Future<void> _onData(String chunk) async {
    state = await AsyncValue.guard(() async {
      final currentState = await future;

      return currentState.copyWith(response: currentState.response + chunk);
    });
  }

  Future<void> _onDone() async {
    state = await AsyncValue.guard(() async {
      final currentState = await future;

      return currentState.copyWith(isConnecting: false);
    });
  }

  Future<void> _onError(Object error) async {
    state = AsyncError(error, StackTrace.current);
  }
}
