import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coins/crypto_app.dart';
import 'package:flutter_coins/repositories/crypto_coins.dart';
import 'package:flutter_coins/repositories/models/crypto_coin_details.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailsAdapter());
  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>('crypto_coins');

  GetIt.I.registerLazySingleton<CryptoCoinsRepository>(
      () => CryptoCoinsRepositoryImpl(Dio(), cryptoCoinsBox));

  runApp(const CryptoApp());
  // FlutterError.onError = (details) {
  //   print("-----Error from ZonedGuarded: $details");
  // };
  // runZonedGuarded(() => runApp(const CryptoApp()), (error, stack) {
  //   print("-----Error from ZonedGuarded: $error");
  // });
}
