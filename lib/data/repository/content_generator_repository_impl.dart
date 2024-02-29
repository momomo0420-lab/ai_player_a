import 'dart:typed_data';

import 'package:ai_player_a/data/data_source/content_generator_data_source.dart';
import 'package:ai_player_a/data/repository/content_generator_repository.dart';

class ContentGeneratorRepositoryImpl implements ContentGeneratorRepository {
  final ContentGeneratorDataSource _dataSource;
  
  const ContentGeneratorRepositoryImpl({
    required ContentGeneratorDataSource dataSource,
  }): _dataSource = dataSource;

  @override
  Stream<String> checkWaitingTile(Uint8List byteData) {
    return _dataSource.checkWaitingTile(byteData);
  }
}