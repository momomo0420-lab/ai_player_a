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

    final repository = ref.read(contentGeneratorRepositoryProvider);
    final byteData = await xFile.readAsBytes();
    final response = repository.checkWaitingTile(byteData);

    response
      .listen(_onData)
      .onDone(_onDone);

    return WaitingTileCheckerState(path: xFile.path, isConnecting: true);
  }

  void _updateState({
    String? path,
    String? response,
    bool? isConnecting,
  }) {
    if(state.value == null) return;
    var stateValue = state.value!;

    if(path != null) stateValue = stateValue.copyWith(path: path);
    if(response != null) stateValue = stateValue.copyWith(response: response);
    if(isConnecting != null) stateValue = stateValue.copyWith(isConnecting: isConnecting);

    state = AsyncData(stateValue);
  }

  void _onData(String chunk) {
    if(state.value == null) return;
    final stateValue = state.value!;

    _updateState(response: stateValue.response + chunk);
  }

  void _onDone() {
    _updateState(isConnecting: false);
  }
}
