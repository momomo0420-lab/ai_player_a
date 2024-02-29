import 'package:ai_player_a/ui/screens/waiting_tile_checker/waiting_tile_checker_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'waiting_tile_checker_view_model.g.dart';

@riverpod
class WaitingTileCheckerViewModel extends _$WaitingTileCheckerViewModel {
  @override
  FutureOr<WaitingTileCheckerState> build() async {
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.camera);
    if(file == null) throw Exception('Error: 画像が取得できませんでした。');

    return WaitingTileCheckerState(path: file.path);
  }
}
