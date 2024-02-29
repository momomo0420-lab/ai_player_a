import 'dart:typed_data';

abstract class ContentGeneratorDataSource {
  Stream<String> checkWaitingTile(Uint8List image);
}