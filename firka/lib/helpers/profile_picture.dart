import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void printSzex() {
  print('szex');
}

Future<void> saveProfilePicture(Uint8List bytes) async {
    var dataDir = await getApplicationDocumentsDirectory();
    var pfpPath = p.join(dataDir.path, "profile.png");
    
}