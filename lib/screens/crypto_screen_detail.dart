
import 'package:auto_route/auto_route.dart';
import 'package:crypto_market/config/colors.dart';
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/model/CryptoCoinDetail.dart';
import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:intl/intl.dart';

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 500,
            child: Chart(
              layers: layers(),
            ),
          ),
          const SizedBox(height: 15,),
          _CustomRowWidget(name: "Open Day", coin: coinDetail.openDay),
          _CustomRowWidget(name: "High Day", coin: coinDetail.highDay),
          _CustomRowWidget(name: "Low Day", coin: coinDetail.lowDay),
          _CustomRowWidget(name: "Change Day", coin: coinDetail.changeDay),
        ],
      ),
    );
  }

  List<ChartLayer> layers() {
    final double frequency =
        (DateTime(2017, 11).millisecondsSinceEpoch.toDouble() -
            DateTime(2017, 4).millisecondsSinceEpoch.toDouble()) /
            4;
    final double frequencyData = frequency / 3;
    final double from = DateTime(2017, 4).millisecondsSinceEpoch.toDouble();
    return [
      ChartGridLayer(
        settings: ChartGridSettings(
          x: ChartGridSettingsAxis(
            color: Colors.white.withOpacity(0.2),
            frequency: frequency,
            max: DateTime(2017, 11).millisecondsSinceEpoch.toDouble(),
            min: DateTime(2017, 4).millisecondsSinceEpoch.toDouble(),
          ),
          y: ChartGridSettingsAxis(
            color: Colors.white.withOpacity(0.2),
            frequency: 3.0,
            max: 66.0,
            min: 48.0,
          ),
        ),
      ),
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: frequency,
            max: DateTime(2017, 11).millisecondsSinceEpoch.toDouble(),
            min: DateTime(2017, 4).millisecondsSinceEpoch.toDouble(),
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: 3.0,
            max: 66.0,
            min: 48.0,
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) => DateFormat('MMM yyyy')
            .format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
        labelY: (value) => value.toInt().toString(),
      ),
      ChartCandleLayer(
        items: [
          _candleItem(Colors.green, 50.0, 52.0, 48.0, 53.0, from),
          _candleItem(
              Colors.red, 52.0, 54.0, 51.0, 57.0, from + frequencyData),
          _candleItem(Colors.red, 53.0, 56.0, 53.0, 56.0,
              from + 2 * frequencyData),
          _candleItem(Colors.green, 54.0, 56.0, 53.0, 58.0,
              from + 3 * frequencyData),
          _candleItem(Colors.green, 55.0, 57.0, 53.0, 58.0,
              from + 4 * frequencyData),
          _candleItem(Colors.green, 56.0, 58.0, 56.0, 58.0,
              from + 5 * frequencyData),
          _candleItem(Colors.red, 58.0, 60.0, 57.0, 61.0,
              from + 6 * frequencyData),
          _candleItem(Colors.green, 57.5, 59.0, 56.5, 60.3,
              from + 7 * frequencyData),
          _candleItem(Colors.green, 57.0, 59.0, 57.0, 60.0,
              from + 8 * frequencyData),
          _candleItem(Colors.red, 60.0, 62.0, 57.0, 61.0,
              from + 9 * frequencyData),
          _candleItem(Colors.green, 63.0, 65.0, 62.0, 66.0,
              from + 10 * frequencyData),
          _candleItem(Colors.green, 64.0, 66.0, 63.0, 66.0,
              from + 11 * frequencyData),
          _candleItem(Colors.red, 62.0, 64.0, 61.0, 64.0,
              from + 12 * frequencyData),
        ],
        settings: const ChartCandleSettings(),
      ),
    ];
  }

  static _candleItem(Color color, double min1, double max1, double min2,
      double max2, double x) {
    return ChartCandleDataItem(
      color: color,
      value1: ChartCandleDataItemValue(
        max: max1,
        min: min1,
      ),
      value2: ChartCandleDataItemValue(
        max: max2,
        min: min2,
      ),
      x: x,
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
