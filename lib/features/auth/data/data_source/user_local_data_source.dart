import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUserId(int id);
  Future<int?> getUserId();
  Future<void> deleteToken();
  Future<void> deleteUserId();
  Future<bool> hasToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  UserLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> saveUserId(int id) async {
    await secureStorage.write(key: _userIdKey, value: id.toString());
  }

  @override
  Future<int?> getUserId() async {
    final idStr = await secureStorage.read(key: _userIdKey);
    return idStr != null ? int.tryParse(idStr) : null;
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: _tokenKey);
  }

  @override
  Future<void> deleteUserId() async {
    await secureStorage.delete(key: _userIdKey);
  }

  @override
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
