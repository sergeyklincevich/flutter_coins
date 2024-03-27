import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coins/features/crypto_details/bloc/crypto_coin_bloc.dart';
import 'package:flutter_coins/generated/l10n.dart';
import 'package:flutter_coins/repositories/crypto_coins.dart';
import 'package:get_it/get_it.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final CryptoCoinBloc _cryptoCoinBloc =
      CryptoCoinBloc(GetIt.I.get<CryptoCoinsRepository>());
  CryptoCoin? coin;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(
        args != null && args is CryptoCoin, "You must provide CryptoCoin Args");
    setState(() {
      coin = args as CryptoCoin;
      _cryptoCoinBloc.add(LoadCryptoCoinEvent(coin!.name));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).crypto_coin_screen_name),
        centerTitle: true,
      ),
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: _cryptoCoinBloc,
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Loaded) {
            final coinDetails = state.coin.details;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 36)),
                  Image.network(
                    coinDetails.fullImageUrl,
                    height: 160,
                    width: 160,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 24)),
                  Text(
                    coin!.name,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12)),
                  Center(
                      child: Text(
                    "${coinDetails.price} \$",
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w700),
                  )),
                  const Padding(padding: EdgeInsets.only(top: 48)),
                  BaseRaw(
                    label: "High price 24 hours",
                    value: coinDetails.highPrice,
                  ),
                  BaseRaw(
                    label: "Low price 24 hours",
                    value: coinDetails.lowPrice,
                  ),
                ],
              ),
            );
          }
          if (state is Error) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    "We get error during update",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Please try again later",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  ElevatedButton(
                      onPressed: () {
                        _cryptoCoinBloc.add(LoadCryptoCoinEvent(coin!.name));
                      },
                      child: const Text("Try again"))
                ]));
          }
          return const Center();
        },
      ),
    );
  }
}

class BaseRaw extends StatelessWidget {
  const BaseRaw({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            "$value \$",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}
