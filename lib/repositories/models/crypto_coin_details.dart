import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetails extends Equatable {
  @HiveField(0)
  @JsonKey(name: 'PRICE')
  final double price;
  @HiveField(1)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;
  @HiveField(2)
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;
  @HiveField(3)
  @JsonKey(
      name: 'LASTUPDATE', toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime lastUpdate;
  @HiveField(4)
  @JsonKey(name: 'HIGH24HOUR')
  final double highPrice;
  @HiveField(5)
  @JsonKey(name: 'LOW24HOUR')
  final double lowPrice;

  String get fullImageUrl => "https://www.cryptocompare.com/$imageUrl";

  const CryptoCoinDetails(this.price, this.imageUrl, this.toSymbol,
      this.lastUpdate, this.highPrice, this.lowPrice);

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);

  @override
  List<Object?> get props =>
      [price, imageUrl, toSymbol, lastUpdate, highPrice, lowPrice];

  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int time) =>
      DateTime.fromMillisecondsSinceEpoch(time);
}
