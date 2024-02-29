import 'dart:typed_data';

abstract class ContentGeneratorRepository {
  Stream<String> listenWaitingTile(Uint8List byteData);
}