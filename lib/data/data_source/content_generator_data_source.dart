import 'dart:typed_data';

abstract class ContentGeneratorDataSource {
  Stream<String> listenWaitingTile(Uint8List image);
}