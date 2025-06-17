import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';

class AlwaysUpdateGoldenFileComparator extends LocalFileComparator {
  AlwaysUpdateGoldenFileComparator(Uri testFile) : super(testFile);

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    // Ensure the golden file goes in test/goldens
    final Uri testGoldensUri = Uri.parse('test/goldens/');
    final String goldenPath = golden.path;
    
    // Remove 'goldens/' prefix if present and rebuild the path
    final String fileName = goldenPath.startsWith('goldens/') 
        ? goldenPath.substring('goldens/'.length)
        : goldenPath;
    
    final Uri finalGoldenUri = testGoldensUri.resolve(fileName);
    final File goldenFile = File.fromUri(finalGoldenUri);
    
    await goldenFile.parent.create(recursive: true);
    await goldenFile.writeAsBytes(imageBytes);
    return true; // Always pass
  }

  @override
  Future<void> update(Uri golden, Uint8List imageBytes) async {
    // This method is called when --update-goldens is used
    // Use the same logic as compare() to ensure consistent paths
    await compare(imageBytes, golden);
  }
}

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Set up always-update golden file comparator for all tests
//  goldenFileComparator = AlwaysUpdateGoldenFileComparator(Uri.parse('test/'));
  
  // Run the tests
  return testMain();
}


