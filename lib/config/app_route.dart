import 'package:auto_route/auto_route.dart';
import 'package:crypto_market/config/app_route.gr.dart';

@AutoRouterConfig()
class AppRoute extends $AppRoute{

  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CryptoListRoute.page, path: '/'),
    AutoRoute(page: CryptoCoinDetailRoute.page),
  ];
}
