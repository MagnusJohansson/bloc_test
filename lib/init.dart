import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Init {
  Init();

  Future doInit() async {
    var databasesPath = await getDatabasesPath();
    var destinationPath = join(databasesPath, "presets.db");

    // Check if the database exists
    var exists = await databaseExists(destinationPath);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new database copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(destinationPath)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "presets.sqlite"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(destinationPath).writeAsBytes(bytes, flush: true);
      print("Database copied.");
    } else {
      print("Opening existing database");
    }
    return;
  }
}
