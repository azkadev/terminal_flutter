import 'dart:typed_data';

class Pty {
  static start(
    dynamic data, {
    dynamic workingDirectory,
    dynamic columns,
    dynamic rows,
  }) {}
  Stream<Uint8List> get output async* {}
  Future<int> get exitCode async {
    return 0;
  }
}
