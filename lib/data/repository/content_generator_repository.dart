import 'dart:typed_data';

abstract class ContentGeneratorRepository {
  Stream<String> checkWaitingTile(Uint8List byteData);
}