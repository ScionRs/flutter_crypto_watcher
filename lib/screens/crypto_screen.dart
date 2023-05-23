import 'dart:async';
import 'package:crypto_market/bloc/crypto_bloc.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  //List<CryptoCoin>? _cryptoCoinsList;
  final _cryptoListBloc = CryptoBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  @override
  void initState(){
    _cryptoListBloc.add(LoadCrypto());
    super.initState();
  }

  /*
  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto'),),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCrypto(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoBloc, CryptoState>(
          bloc: _cryptoListBloc,
          builder: (context, state){
            if(state is CryptoLoaded){
              return ListView.builder(
                  itemCount: state.coinsList.length,
                  itemBuilder: (context, i){
                    final coin = state.coinsList[i];
                    return Text(coin.name);
                  });
            }
            if(state is CryptoLoadingFailure){
              return Text(state.exception.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }
    ),
      ),

    );
  }
}
