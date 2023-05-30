
import 'package:auto_route/auto_route.dart';
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/model/CryptoCoinDetail.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CryptoCoinDetailScreen extends StatelessWidget {
  final CryptoCoin coinDetail;
  const CryptoCoinDetailScreen({Key? key, required this.coinDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Detail"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Text(coinDetail.name),
          ],
        ),
      ),
    );
  }
}
