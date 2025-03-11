import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
part 'token_model.g.dart';

class TokenModel {
  Id id = Isar.autoIncrement; // Auto-increment internal ID

  @Index(unique: true, replace: true)
  int? StudentId; // Custom unique student identifier

  String? tokenId; // Unique identifier for the token if needed
  String? accessToken; // The main auth token
  String? refreshToken; // Token used to refresh the access token
  DateTime? expiryDate; // When the token expires
}
