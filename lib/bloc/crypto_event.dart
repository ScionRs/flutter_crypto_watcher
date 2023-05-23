part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();
}

class LoadCrypto extends CryptoEvent{
  LoadCrypto({
    this.completer,
});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];


}