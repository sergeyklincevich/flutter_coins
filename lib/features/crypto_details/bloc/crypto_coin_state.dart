part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinState {}

class Initial extends CryptoCoinState {}

class Loading extends CryptoCoinState {}

class Loaded extends CryptoCoinState {
  final CryptoCoin coin;

  Loaded(this.coin);
}

class Error extends CryptoCoinState {
  final String errorMessage;

  Error(this.errorMessage);
}
