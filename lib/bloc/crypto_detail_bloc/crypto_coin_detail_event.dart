part of 'crypto_coin_detail_bloc.dart';

abstract class CryptoCoinDetailEvent extends Equatable {
  const CryptoCoinDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadCryptoCoinDetail extends CryptoCoinDetailEvent{
  final String currencyCode;

  const LoadCryptoCoinDetail({required this.currencyCode});

  @override
  List<Object?> get props => super.props..add(currencyCode);

}
