import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_coins/repositories/crypto_coins.dart';
import 'package:flutter_coins/repositories/models/crypto_coin_details.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CryptoCoinsRepositoryImpl implements CryptoCoinsRepository {
  CryptoCoinsRepositoryImpl(this.dio, this.cryptoCoinsBox);

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCoins() async {
    var list = <CryptoCoin>[];
    try {
      list = await getRemoteCoins();

      final map = {for (var item in list) item.name: item};
      await cryptoCoinsBox.putAll(map);
    } catch (e) {
      debugPrint("Some error during fetch Crypto Coins: $e");
      list = cryptoCoinsBox.values.toList();
    }
    list.sort((a, b) => b.details.price.compareTo(a.details.price));
    return list;
  }

  Future<List<CryptoCoin>> getRemoteCoins() async {
    final response = await dio.get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD");
    debugPrint(response.toString());

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data["RAW"] as Map<String, dynamic>;
    final list = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)["USD"] as Map<String, dynamic>;
      final details = CryptoCoinDetails.fromJson(usdData);
      return CryptoCoin(e.key, details);
    }).toList();
    return list;
  }

  @override
  Future<CryptoCoin> getCoin(String code) async {
    try {
      final coin = await getCoinRemote(code);
      cryptoCoinsBox.put(code, coin);
      return coin;
    } catch (e) {
      debugPrint("Error during fetching Coin $code : $e");
      return cryptoCoinsBox.get(code)!;
    }
  }

  Future<CryptoCoin> getCoinRemote(String code) async {
    final response = await dio.get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$code&tsyms=USD");
    debugPrint(response.toString());

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[code] as Map<String, dynamic>;
    final usdData = coinData["USD"] as Map<String, dynamic>;
    final details = CryptoCoinDetails.fromJson(usdData);

    return CryptoCoin(code, details);
  }
}
