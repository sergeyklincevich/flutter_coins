import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coins/repositories/crypto_coins.dart';
import 'package:flutter_coins/repositories/models/crypto_coin_details.dart';

part 'crypto_coin_event.dart';part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  final CryptoCoinsRepository repository;

  CryptoCoinBloc(this.repository) : super(Initial()) {
    on<LoadCryptoCoinEvent>((event, emit) async {
      try {
        if (state is! Loaded) {
          emit(Loading());
        }
        CryptoCoin coin = await repository.getCoin(event.currencyCode);
        emit(Loaded(coin));
      } catch (e) {
        String errorMessage = "Error during fetching Coin details: ${e}";
        debugPrint(errorMessage);
        emit(Error(errorMessage));
      }
    });
  }
}
