import 'package:crypto_market/config/theme.dart';

import 'screens/crypto_screen.dart';
import 'package:crypto_market/repository/AbstractCoinsRepository.dart';
import 'package:crypto_market/repository/CryptoCoinsRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
        () => CryptoCoinsRepository(dio: Dio()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: CryptoListScreen(),
    );
  }
}


