
class CryptoService{
  // возвращаем изменения за день
  static double getPercentChange(double changeDay, double priceInRUB) {
    return ((changeDay / priceInRUB) * 100.0);
  }
}