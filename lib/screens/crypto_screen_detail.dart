
import 'package:auto_route/auto_route.dart';
import 'package:crypto_market/bloc/crypto_detail_bloc/crypto_coin_detail_bloc.dart';
import 'package:crypto_market/bloc/crypto_detail_bloc/crypto_coin_detail_bloc.dart';
import 'package:crypto_market/config/colors.dart';
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:intl/intl.dart';

@RoutePage()
class CryptoCoinDetailScreen extends StatefulWidget {
  final CryptoCoin coinDetail;

  CryptoCoinDetailScreen({Key? key, required this.coinDetail})
      : super(key: key);

  @override
  State<CryptoCoinDetailScreen> createState() => _CryptoCoinDetailScreenState();
}

class _CryptoCoinDetailScreenState extends State<CryptoCoinDetailScreen> {
  final _coinDetailsBloc = CryptoCoinDetailBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  @override
  void initState() {
    _coinDetailsBloc.add(
        LoadCryptoCoinDetail(currencyCode: widget.coinDetail.name));
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      backgroundColor: AppColors.black2,
      appBar: AppBar(
        backgroundColor: AppColors.black2,
        title: Text("${widget.coinDetail.name} Detail"),
        centerTitle: true,
      ),
      body: BlocBuilder<CryptoCoinDetailBloc, CryptoCoinDetailState>(
        bloc: _coinDetailsBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailLoaded) {
            return ListView.builder(
                itemCount: state.coinList.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = state.coinList[index];
                  return Text(item.high.toString());
                });
          }
          if (state is CryptoCoinDetailFailure) {
            return Text(state.exception.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

/*
ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 15,),
          _CustomRowWidget(name: "Open Day", coin: widget.coinDetail.openDay),
          _CustomRowWidget(name: "High Day", coin: widget.coinDetail.highDay),
          _CustomRowWidget(name: "Low Day", coin: widget.coinDetail.lowDay),
          _CustomRowWidget(name: "Change Day", coin: widget.coinDetail.changeDay),
        ],
      ),
 */
  /*
    SizedBox(
            height: 500,
            child: BlocBuilder<CryptoCoinDetailBloc, CryptoCoinDetailState>(
              builder: (context, state) {
                if (state is CryptoCoinDetailLoaded) {
                  final double frequency =
                      (state.coin[0].dateTime.millisecondsSinceEpoch.toDouble() -
                          state.coin.last.dateTime.millisecondsSinceEpoch.toDouble()) /
                          4;
                  final double maxValue = state.coin[0].dateTime.millisecondsSinceEpoch.toDouble();
                  final double minValue =  state.coin.last.dateTime.millisecondsSinceEpoch.toDouble();
                  final double frequencyData = frequency / 3;
                  final double from = DateTime(2017, 4).millisecondsSinceEpoch.toDouble();
                  return Chart(
                    layers: [
                      ChartGridLayer(
                        settings: ChartGridSettings(
                          x: ChartGridSettingsAxis(
                            color: Colors.white.withOpacity(0.2),
                            frequency: frequency,
                            max: maxValue,
                            min: minValue,
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
                            max: maxValue,
                            min: minValue,
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
                        labelX: (value) =>
                            DateFormat('MMM yyyy')
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                value.toInt())),
                        labelY: (value) => value.toInt().toString(),
                      ),
                      ChartCandleLayer(
                        items: [
                          for(var item in state.coin)
                            CryptoCoinDetailScreen._candleItem(
                                Colors.red, 52.0, 54.0, 51.0, 57.0, from),
                        ],
                        settings: const ChartCandleSettings(),
                      ),
                    ],
                  );
                }
                if(state is CryptoCoinDetailFailure){
                  return Text(state.exception.toString());
                }
                return const Center(child: CircularProgressIndicator());
  },
),
          ),
   */



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
