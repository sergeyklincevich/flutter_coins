part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinEvent {}

class LoadCryptoCoinEvent extends CryptoCoinEvent {
  final String currencyCode;

  LoadCryptoCoinEvent(this.currencyCode);
}
