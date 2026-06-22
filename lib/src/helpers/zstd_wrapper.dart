import 'dart:typed_data' show Uint8List;

import 'package:zstandard/zstandard.dart';

abstract class ZstdDecompressor {
  Future<Uint8List?> decompress(Uint8List data);
}

class DefaultZstdDecompressor implements ZstdDecompressor {
  final zstd = Zstandard();

  @override
  Future<Uint8List?> decompress(Uint8List data) => zstd.decompress(data);
}
