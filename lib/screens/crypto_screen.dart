import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:crypto_market/bloc/crypto_bloc.dart';
import 'package:crypto_market/bloc/crypto_detail_bloc/crypto_coin_detail_bloc.dart';
import 'package:crypto_market/config/app_route.gr.dart';
import 'package:crypto_market/config/colors.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:crypto_market/screens/crypto_screen_detail.dart';
import 'package:crypto_market/service/crypto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
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

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.black2,
      appBar: _AppBarWidget(cryptoListBloc: _cryptoListBloc),
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.coinsList.length,
                  itemBuilder: (context, i){
                    final coin = state.coinsList[i];
                    // изменения за день
                    num cryptoChange = CryptoService.getPercentChange(coin.changeDay,coin.priceInUSD);
                    // проверяем в плюсе ли значение или нет
                    bool isCryptoChangePlus = cryptoChange > 0 ? true : false;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: (){
                          AutoRouter.of(context).push(CryptoCoinDetailRoute(coinDetail: coin));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.network(
                              coin.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(coin.name, style: textTheme.titleLarge,),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('\$${coin.priceInUSD}', style: textTheme.titleMedium,),
                              Text('${cryptoChange.toStringAsFixed(3)} %',
                                style: textTheme.titleSmall!.copyWith(color: isCryptoChangePlus ? AppColors.success : AppColors.error),),
                            ],
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                          dense: true, // Компактный виджет
                          shape: const Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    );
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

class _AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  const _AppBarWidget({
    super.key,
    required CryptoBloc cryptoListBloc,
  }) : _cryptoListBloc = cryptoListBloc;

  final CryptoBloc _cryptoListBloc;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Cryptocurrency Watcher'),
      centerTitle: true,
      actions:[
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: IconButton(onPressed: (){
            _cryptoListBloc.add(LoadCrypto());
          },
              icon: const Icon(Icons.refresh,size: 30.0,)),
        )
      ],
      backgroundColor: AppColors.black2,
      shadowColor: Colors.transparent,
     );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
