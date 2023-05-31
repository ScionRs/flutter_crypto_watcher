
import 'package:crypto_market/model/Crypto.dart';
import 'package:crypto_market/model/CryptoCoinDetail.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository{

  final Dio dio;


  CryptoCoinsRepository({required this.dio});

  @override
  Future<List<CryptoCoin>> getCoinsList() async{
    String websiteUrl = "https://www.cryptocompare.com/";
    final response = await dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV&tsyms=USD,EUR,RUB');
    final data = response.data;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoList = dataRaw.entries.map((item) {
      final rubData = (item.value as Map <String, dynamic>)['RUB'];
      final priceRUB = rubData['PRICE'];
      final imageUrl = rubData['IMAGEURL'];
      final openDay = rubData['OPENDAY'];
      final highDay = rubData['HIGHDAY'];
      final lowDay = rubData['LOWDAY'];
      final changeDay = rubData['CHANGEDAY'];

      return CryptoCoin(
        name: item.key,
        priceInRUB: priceRUB,
        imageUrl: websiteUrl + imageUrl,
        openDay: openDay,
        highDay: highDay,
        lowDay: lowDay,
        changeDay: changeDay,
      );
    }).toList();
    print(cryptoList);
    return cryptoList;
  }


  @override
  Future<List<CryptoCoinDetail>> getCoinGraphDetails(String currencyCode) async{
    String websiteUrl = "https://min-api.cryptocompare.com/data/exchange/histoday?fsum=${currencyCode}&tsym=RUB&limit=10";
    final response = await dio.get(websiteUrl);
    final data = response.data;
    final dataFirst = data['Data'] as Map<String, dynamic>;
    final cryptoChangeOfDay = dataFirst.entries.map((item) {
      final cryptoCoinData = (item.value as Map<String, dynamic>)['Data'];
      final high = cryptoCoinData['high'];
      final low = cryptoCoinData['low'];
      final open = cryptoCoinData['open'];
      final close = cryptoCoinData['close'];
      final dateTime = cryptoCoinData['time'];
      return CryptoCoinDetail(
          high: high,
          low: low,
          open: open,
          close: close,
          dateTime: DateTime.fromMillisecondsSinceEpoch(dateTime * 1000),
      );
    }).toList();
    print(cryptoChangeOfDay);
    return cryptoChangeOfDay;
  }
}