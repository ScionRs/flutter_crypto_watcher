
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/model/CryptoCoinDetail.dart';

abstract class AbstractCoinsRepository{
  Future<List<CryptoCoin>> getCoinsList();
  Future<List<CryptoCoinDetail>> getCoinGraphDetails(String currencyCode);
}