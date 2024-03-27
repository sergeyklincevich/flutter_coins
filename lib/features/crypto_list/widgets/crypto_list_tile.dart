import 'package:flutter/material.dart';
import 'package:flutter_coins/repositories/models/crypto_coin.dart';

ListTile cryptoListTile(CryptoCoin coin, BuildContext context) {
  return ListTile(
    leading: Image.network(coin.details.fullImageUrl),
    // leading: SvgPicture.asset(
    // 'assets/svg/bitcoin-logo.svg',
    // height: 30,
    // width: 30,
    // ),
    title: Text(
      coin.name,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    subtitle: Text(
      "${coin.details.price} \$",
      style: Theme.of(context).textTheme.labelSmall,
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.of(context).pushNamed("/coin", arguments: coin);
    },
  );
}
