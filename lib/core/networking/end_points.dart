import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String server = dotenv.env['SERVER'] ?? '';
  static String getTimeframe = "${server}timeframe";
}
