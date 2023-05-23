part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();
}

class CryptoInitial extends CryptoState {
  @override
  List<Object> get props => [];
}

class CryptoLoading extends CryptoState{
  @override
  List<Object?> get props => [];

}

class CryptoLoaded extends CryptoState{
  final List<CryptoCoin> coinsList;
  CryptoLoaded({
    required this.coinsList,
  });

  @override
  List<Object?> get props => [coinsList];

}

class CryptoLoadingFailure extends CryptoState{
  final Object? exception;

  CryptoLoadingFailure({
    this.exception
});
  @override
  List<Object?> get props => [exception];

}
