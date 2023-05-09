
import 'package:crypto_market/model/Crypto.dart';

abstract class AbstractCoinsRepository{
  Future<List<CryptoCoin>> getCoinsList();
}