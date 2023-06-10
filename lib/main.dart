import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/data/core/service/storage/hive_service_provider.dart';
import 'package:unsplash/data/core/service/storage/hive_storage_service.dart';
import 'package:unsplash/data/core/service/storage/storage_service.dart';
import 'package:unsplash/presentation/home/home_page.dart';
import 'package:unsplash/presentation/util/helper/navigator.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded<Future<void>>(
    () async {
      // Hive-specific initialization
      await Hive.initFlutter();
      final StorageService initializedStorageService = HiveStorageService();
      await initializedStorageService.init();

      runApp(
        ProviderScope(
          overrides: [
            storageServiceProvider.overrideWithValue(initializedStorageService),
          ],
          child: const MyApp(),
        ),
      );
    },
    // ignore: only_throw_errors
    (e, _) => throw e,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'unsplash',
      navigatorKey: navigator.key,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageView(),
    );
  }
}
