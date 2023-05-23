import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:equatable/equatable.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final AbstractCoinsRepository coinsRepository;

  CryptoBloc(this.coinsRepository) : super(CryptoInitial()) {
    on<LoadCrypto>((event, emit) async{
      try{
        if (state is! CryptoLoaded){
          emit(CryptoLoading());
        }
        final coinsList = await coinsRepository.getCoinsList();
        emit(CryptoLoaded(coinsList: coinsList));
      } catch (e) {
        emit(CryptoLoadingFailure(exception: e));
      } finally{
        event.completer?.complete();
      }
    });
  }
}
