import 'dart:typed_data';

abstract class WaitingTileCheckerDataSource {
  Stream<String> check(Uint8List image);
}