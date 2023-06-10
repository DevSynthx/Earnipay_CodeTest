import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:unsplash/data/core/service/storage/hive_storage_service.dart';
import 'package:unsplash/data/core/service/storage/storage_service.dart';

void main() {
  final StorageService hiveStorageService = HiveStorageService();
  const testStorageKey = 'test';

  setUp(() async {
    await setUpTestHive();
    await hiveStorageService.init();
  });
  test('store & get value', () async {
    await hiveStorageService.set(testStorageKey, 'someValue');
    expect(hiveStorageService.get(testStorageKey), 'someValue');
  });

  test('Can check if key exists', () async {
    await hiveStorageService.set(testStorageKey, 'someValue');
    expect(hiveStorageService.has(testStorageKey), true);

    await hiveStorageService.remove(testStorageKey);
    expect(hiveStorageService.has(testStorageKey), false);
  });

  test('Can get all values', () async {
    await hiveStorageService.set(testStorageKey, 'someValue');
    await hiveStorageService.set('test2', 'otherValue');

    expect(hiveStorageService.getAll(), ['someValue', 'otherValue']);
  });

  tearDown(() async {
    await hiveStorageService.close();
  });
}
