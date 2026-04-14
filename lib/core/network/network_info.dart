import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Network Information Interface
/// Provides network connectivity status
abstract class NetworkInfo {
  /// Checks if device is connected to internet
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<InternetConnectionStatus> get onStatusChange;
}

/// Implementation of NetworkInfo using internet_connection_checker
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    try {
      // We add a timeout and a fallback to 'true' to ensure that if the check itself hangs 
      // or fails (common on some Windows/Local setups), we still attempt the request.
      // Dio will handle the actual connection failure if the server is truly unreachable.
      return await connectionChecker.hasConnection.timeout(
        const Duration(seconds: 3),
        onTimeout: () => true,
      );
    } catch (_) {
      return true;
    }
  }

  @override
  Stream<InternetConnectionStatus> get onStatusChange =>
      connectionChecker.onStatusChange;
}
