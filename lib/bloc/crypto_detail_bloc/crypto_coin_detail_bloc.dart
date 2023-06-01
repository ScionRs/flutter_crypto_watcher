import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_market/model/CryptoCoinDetail.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:equatable/equatable.dart';

part 'crypto_coin_detail_event.dart';
part 'crypto_coin_detail_state.dart';

class CryptoCoinDetailBloc extends Bloc<CryptoCoinDetailEvent, CryptoCoinDetailState> {
  final AbstractCoinsRepository coinsRepository;
  CryptoCoinDetailBloc(this.coinsRepository) : super(CryptoCoinDetailState()) {
    on<LoadCryptoCoinDetail>(_load);}

  Future<void> _load(
      LoadCryptoCoinDetail event,
      Emitter<CryptoCoinDetailState> emit
      ) async {
    try{
      if (state is! CryptoCoinDetailLoaded){
        emit(CryptoCoinDetailLoading());
      }
      final coinDetail = await coinsRepository.getCoinGraphDetails(event.currencyCode);
      emit(CryptoCoinDetailLoaded(coinList: coinDetail));
    } catch (e, st){
      print("${e} ${st}");
      emit(CryptoCoinDetailFailure(e));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace){
    super.onError(error, stackTrace);
  }
}
