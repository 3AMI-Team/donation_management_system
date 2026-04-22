import 'dart:developer';

import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  log('Starting check...');
  try {
    // Some versions use .instance, some use unnamed constructor
    final checker = InternetConnectionChecker.instance;
    log('Using .instance');
    final hasConnection = await checker.hasConnection;
    log('Has connection: $hasConnection');
  } catch (e) {
    log('Error: $e');
  }
}
