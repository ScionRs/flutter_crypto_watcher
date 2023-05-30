import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:crypto_market/bloc/crypto_bloc.dart';
import 'package:crypto_market/config/colors.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
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

  /*
  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }
*/
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.black2,
      appBar: AppBar(
        title: const Text('Crypto'),
        backgroundColor: AppColors.black2,
        shadowColor: Colors.transparent,
       ),
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
                    double cryptoChange = CryptoService.getPercentChange(coin.changeDay,coin.priceInRUB);
                    // проверяем в плюсе ли значение или нет
                    bool isCryptoChangePlus = cryptoChange > 0 ? true : false;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            Text('${coin.priceInRUB}', style: textTheme.titleMedium,),
                            Text('${cryptoChange.toStringAsFixed(3)} %',
                              style: textTheme.titleSmall!.copyWith(color: isCryptoChangePlus ? AppColors.success : AppColors.error),),
                          ],
                        ),
                        onTap: () {

                        },
                        selected: true, // Выбранный элемент списка
                        enabled: false, // Отключенный элемент списка
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                        dense: true, // Компактный виджет
                        shape: const Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey),
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
