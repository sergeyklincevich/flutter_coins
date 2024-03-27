import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coins/repositories/crypto_coins.dart';

part 'crypto_list_event.dart';part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final CryptoCoinsRepository repository;

  CryptoListBloc(this.repository) : super(Initial()) {
    on<LoadCryptoList>((event, emit) async {
      debugPrint("--- triggered LoadCryptoList event");
      try {
        if (state is! Loaded) {
          emit(Loading());
        }
        var result = await repository.getCoins();
        // await Future.delayed(const Duration(seconds: 2));
        emit(Loaded(result));
      } catch (e) {
        final error = "Error during fetching data for crypto coins:$e";
        debugPrint(error);
        emit(Error(error));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
