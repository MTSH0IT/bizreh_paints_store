import 'package:bizreh_paints_store/utils/storageService/storage_service.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';

/// Abstract token provider interface
abstract class ITokenProvider {
  String? getToken();
  Future<void> setToken(String? token);
  Future<void> clearToken();
}

/// Implementation of token provider using StorageService
class TokenProvider implements ITokenProvider {
  final StorageService _storageService;

  TokenProvider({required StorageService storageService}) 
      : _storageService = storageService;

  @override
  String? getToken() {
    return _storageService.getString(StorageKey.token);
  }

  @override
  Future<void> setToken(String? token) async {
    if (token != null && token.isNotEmpty) {
      await _storageService.setString(StorageKey.token, token);
    } else {
      await clearToken();
    }
  }

  @override
  Future<void> clearToken() async {
    await _storageService.remove(StorageKey.token);
  }
}
