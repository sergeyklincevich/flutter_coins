import 'package:flutter_coins/repositories/crypto_coins.dart';

abstract class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoins();

  Future<CryptoCoin> getCoin(String code);
}
