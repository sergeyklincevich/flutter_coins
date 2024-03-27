import 'package:equatable/equatable.dart';
import 'package:flutter_coins/repositories/models/crypto_coin_details.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CryptoCoin extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoCoinDetails details;

  const CryptoCoin(this.name, this.details);

  @override
  List<Object?> get props => [name, details.props];

  factory CryptoCoin.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinToJson(this);
}
