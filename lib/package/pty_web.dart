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
  /// Resize the pseudo-terminal.
  void resize(int rows, int cols) {
    
  }
  /// Write data to the pseudo-terminal.
  void write(Uint8List data) {
    
  }

}
