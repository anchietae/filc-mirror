import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models/token_model.dart';

class TokenService {
  late Future<Isar> db;

  // Initialize the database
  TokenService() {
    db = openDB();
  }

  // Open the Isar database
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [TokenModelSchema],
      directory: dir.path,
    );
  }
}