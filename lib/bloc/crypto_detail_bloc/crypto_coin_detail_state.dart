part of 'crypto_coin_detail_bloc.dart';

class CryptoCoinDetailState extends Equatable {
  const CryptoCoinDetailState();

  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailLoading extends CryptoCoinDetailState {
  @override
  List<Object> get props => [];
}

class CryptoCoinDetailLoaded extends CryptoCoinDetailState{
  final List<CryptoCoinDetail> coin;

  const CryptoCoinDetailLoaded(this.coin);

  @override
  List<Object?> get props => [coin];

}

class CryptoCoinDetailFailure extends CryptoCoinDetailState{
  final Object exception;
  
  const CryptoCoinDetailFailure(this.exception);

  @override
  List<Object?> get props => super.props..add(exception);
}