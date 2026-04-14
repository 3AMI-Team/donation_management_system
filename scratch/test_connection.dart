import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  print('Starting check...');
  try {
    // Some versions use .instance, some use unnamed constructor
    final checker = InternetConnectionChecker.instance;
    print('Using .instance');
    final hasConnection = await checker.hasConnection;
    print('Has connection: $hasConnection');
  } catch (e) {
    print('Error: $e');
  }
}
