
import 'package:auto_route/auto_route.dart';
import 'package:crypto_market/config/colors.dart';
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/model/CryptoCoinDetail.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CryptoCoinDetailScreen extends StatelessWidget {
  final CryptoCoin coinDetail;
  const CryptoCoinDetailScreen({Key? key, required this.coinDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.black2,
      appBar: AppBar(
        backgroundColor: AppColors.black2,
        title: Text("${coinDetail.name} Detail"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _CustomRowWidget(name: "Open Day", coin: coinDetail.openDay),
          _CustomRowWidget(name: "High Day", coin: coinDetail.highDay),
          _CustomRowWidget(name: "Low Day", coin: coinDetail.lowDay),
          _CustomRowWidget(name: "Change Day", coin: coinDetail.changeDay),
        ],
      ),
    );
  }
}

class _CustomRowWidget extends StatelessWidget {
  final String name;
  final num coin;
  const _CustomRowWidget({Key? key,  required this.name, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      color: AppColors.black1,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(name, style: textTheme.titleLarge,),
          Text(coin.toStringAsFixed(2), style: textTheme.titleLarge,),
        ],
      ),
    );
  }
}
