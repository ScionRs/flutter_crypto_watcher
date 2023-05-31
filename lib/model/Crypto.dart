
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  const CryptoCoin({
    required this.name,
    required this.priceInRUB,
    required this.imageUrl,
    required this.openDay,
    required this.highDay,
    required this.lowDay,
    required this.changeDay,
  });

  final String name;
  final num priceInRUB;
  final String imageUrl;
  final num openDay;
  final num highDay;
  final num lowDay;
  final num changeDay;

  @override
  List<Object> get props => [name, priceInRUB, imageUrl];
}