import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coins/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:flutter_coins/features/crypto_list/widgets/widgets.dart';
import 'package:flutter_coins/generated/l10n.dart';
import 'package:flutter_coins/repositories/crypto_coins.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  // List<CryptoCoin>? _cryptoList;

  final _cryptoListBloc = CryptoListBloc(GetIt.I.get<CryptoCoinsRepository>());

  @override
  void initState() {
    // _loadData();
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).crypto_list_screen_name)),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
              bloc: _cryptoListBloc,
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
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
                              _cryptoListBloc.add(LoadCryptoList());
                            },
                            child: const Text("Try again"))
                      ]));
                }
                if (state is Loaded) {
                  return ListView.separated(
                      itemCount: state.coins.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final coin = state.coins[index];
                        return cryptoListTile(coin, context);
                      });
                }
                return Container();
              }),
        ));
  }

// void _loadData() async {
//   _cryptoList = await GetIt.I<CryptoCoinsRepository>().getCoins();
//CryptoCoinsRepositoryImpl(Dio()).getCoins();
//   setState(() {});
// }
}
