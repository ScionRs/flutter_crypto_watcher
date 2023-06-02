
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:crypto_market/bloc/crypto_detail_bloc/crypto_coin_detail_bloc.dart';
import 'package:crypto_market/config/colors.dart';
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_skeleton_niu/loading_skeleton.dart';

@RoutePage()
class CryptoCoinDetailScreen extends StatefulWidget {
  final CryptoCoin coinDetail;

  const CryptoCoinDetailScreen({Key? key, required this.coinDetail})
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
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: SizedBox(
              height: 400,
              child: BlocBuilder<CryptoCoinDetailBloc, CryptoCoinDetailState>(
                bloc: _coinDetailsBloc,
                builder: (context, state) {
                  if (state is CryptoCoinDetailLoaded) {
                    var closeVolume = state.coinList.map((e) => e.close).toList();
                    var openVolume = state.coinList.map((e) => e.open).toList();
                    var highVolume = state.coinList.map((e) => e.high).toList();
                    var lowVolume = state.coinList.map((e) => e.low).toList();
                    return
                      CarouselSlider(
                          items: [
                          _ChartWidget(text: 'Open Index', volumeList: openVolume),
                          _ChartWidget(text: 'Close Index', volumeList: closeVolume),
                          _ChartWidget(text: 'High Index', volumeList: highVolume),
                          _ChartWidget(text: 'Low Index', volumeList: lowVolume),
                          ],
                          options: CarouselOptions(
                            height: 400,
                            aspectRatio: 16/9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          )
                      );
                  }
                  if(state is CryptoCoinDetailFailure){
                    return Text(state.exception.toString());
                  }
                  return Center(child: LoadingSkeleton(
                    width: double.infinity,
                    height: 400,
                    margin: EdgeInsets.all(16),
                  ),);
                },
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Text('Today\'s indicators', style: textTheme.titleLarge,textAlign: TextAlign.center,),
          const SizedBox(height: 15,),
          _CustomRowWidget(name: "Open Day", coin: widget.coinDetail.openDay),
          _CustomRowWidget(name: "High Day", coin: widget.coinDetail.highDay),
          _CustomRowWidget(name: "Low Day", coin: widget.coinDetail.lowDay),
          _CustomRowWidget(name: "Change Day", coin: widget.coinDetail.changeDay),
        ],
      )
    );
  }
}

class _ChartWidget extends StatelessWidget {
  String text;
  final List<double> volumeList;
  _ChartWidget({Key? key,required this.text ,required this.volumeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(text,style: textTheme.titleLarge,),
        const SizedBox(height: 15,),
        Expanded(
          child: Sparkline(
            data: volumeList,
            sharpCorners: true,
            pointsMode: PointsMode.all,
            pointSize: 8.0,
            pointColor: Colors.amber,
            enableGridLines: true,
            gridLinelabelPrefix: '\$',
          ),
        ),
      ],
    );;
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
