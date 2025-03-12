/*
        Firka, alternative e-Kréta client.
        Copyright (C) 2025  QwIT Development

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU Affero General Public License as
        published by the Free Software Foundation, either version 3 of the
        License, or (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU Affero General Public License for more details.

        You should have received a copy of the GNU Affero General Public License
        along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/token_model.dart';

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
      inspector: true,
      schemas: [TokenModelSchema],
      directory: dir.path,
    );
  }

}