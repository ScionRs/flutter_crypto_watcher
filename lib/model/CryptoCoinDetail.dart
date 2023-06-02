
import 'package:equatable/equatable.dart';

class CryptoCoinDetail extends Equatable{
  final double high;
  final double low;
  final double open;
  final double close;
  final DateTime dateTime;

  const CryptoCoinDetail({required this.high,required this.low,required this.open,required this.close, required this.dateTime});

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) {
    return CryptoCoinDetail(
      high: double.parse(json['high'].toString()),
      low: double.parse(json['low'].toString()),
      open: double.parse(json['open'].toString()),
      close: double.parse(json['close'].toString()),
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000),
    );
  }

  @override
  List<Object> get props => [high,low,open,close,dateTime];
}