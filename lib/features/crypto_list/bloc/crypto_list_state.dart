part of 'crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {}

class Initial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class Loading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class Loaded extends CryptoListState {
  final List<CryptoCoin> coins;

  Loaded(this.coins);

  @override
  List<Object?> get props => [coins];
}

class Error extends CryptoListState {
  String errorMessage;

  Error(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
