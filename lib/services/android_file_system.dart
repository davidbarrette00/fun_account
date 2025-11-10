import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AndroidFileStorage {
  final String fileName;

  AndroidFileStorage(this.fileName);

  /// Gets the local file reference
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  /// Writes a string to the file
  Future<void> writeString(String content) async {
    final file = await _localFile;
    await file.writeAsString(content);
  }

  /// Reads the string from the file
  Future<String?> readString() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        return await file.readAsString();
      } else {
        return null;
      }
    } catch (e) {
      log("Error reading file: $e");
      return null;
    }
  }

  /// Deletes the file
  Future<void> deleteFile() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Save to file
  void saveData(String userData) async {
    await writeString(userData);
  }

  /// Load from file
  Future<String?> loadData() async {
    final content = await readString();
    return content;
  }

  /// Append new data (keeps existing content)
  Future<void> appendString(String data) async {
    final file = await _localFile;
    await file.writeAsString('$data\n', mode: FileMode.append);
  }

}
