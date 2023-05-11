

import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState(){
    _loadCryptoCoins();
    super.initState();
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto'),),
      body: (_cryptoCoinsList == null)
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: _cryptoCoinsList!.length,
          itemBuilder: (context, index) {
            return Text('${_cryptoCoinsList![index]}');
          }),
    );
  }
}
