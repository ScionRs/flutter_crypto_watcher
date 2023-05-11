part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();
}

class CryptoInitial extends CryptoState {
  @override
  List<Object> get props => [];
}
