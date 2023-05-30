// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:crypto_market/model/Crypto.dart' as _i5;
import 'package:crypto_market/screens/crypto_screen.dart' as _i1;
import 'package:crypto_market/screens/crypto_screen_detail.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

abstract class $AppRoute extends _i3.RootStackRouter {
  $AppRoute({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    CryptoListRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CryptoListScreen(),
      );
    },
    CryptoCoinDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CryptoCoinDetailRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CryptoCoinDetailScreen(
          key: args.key,
          coinDetail: args.coinDetail,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CryptoListScreen]
class CryptoListRoute extends _i3.PageRouteInfo<void> {
  const CryptoListRoute({List<_i3.PageRouteInfo>? children})
      : super(
          CryptoListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CryptoListRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CryptoCoinDetailScreen]
class CryptoCoinDetailRoute
    extends _i3.PageRouteInfo<CryptoCoinDetailRouteArgs> {
  CryptoCoinDetailRoute({
    _i4.Key? key,
    required _i5.CryptoCoin coinDetail,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          CryptoCoinDetailRoute.name,
          args: CryptoCoinDetailRouteArgs(
            key: key,
            coinDetail: coinDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'CryptoCoinDetailRoute';

  static const _i3.PageInfo<CryptoCoinDetailRouteArgs> page =
      _i3.PageInfo<CryptoCoinDetailRouteArgs>(name);
}

class CryptoCoinDetailRouteArgs {
  const CryptoCoinDetailRouteArgs({
    this.key,
    required this.coinDetail,
  });

  final _i4.Key? key;

  final _i5.CryptoCoin coinDetail;

  @override
  String toString() {
    return 'CryptoCoinDetailRouteArgs{key: $key, coinDetail: $coinDetail}';
  }
}
