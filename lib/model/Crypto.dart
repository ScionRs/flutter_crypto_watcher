
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  const CryptoCoin({
    required this.name,
    required this.priceInRUB,
    required this.priceInEUR,
    required this.priceInUSD,
    required this.imageUrl,
    required this.openDay,
    required this.highDay,
    required this.lowDay,
    required this.changeDay,
  });

  final String name;
  final double priceInRUB;
  final double priceInEUR;
  final double priceInUSD;
  final String imageUrl;
  final double openDay;
  final double highDay;
  final double lowDay;
  final double changeDay;

  @override
  List<Object> get props => [name, priceInRUB, imageUrl];
}