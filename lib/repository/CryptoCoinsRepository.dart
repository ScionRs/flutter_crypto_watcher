
import 'package:crypto_market/model/Crypto.dart';
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
}