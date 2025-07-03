import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String get transBaseurl => dotenv.env['BASE_URL'] ?? '';
}