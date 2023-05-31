
class CryptoService{
  // возвращаем изменения за день
  static num getPercentChange(num changeDay, num priceInRUB) {
    return ((changeDay / priceInRUB) * 100.0);
  }
}