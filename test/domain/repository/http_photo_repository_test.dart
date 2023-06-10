import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash/domain/model/photos.dart';
import 'package:unsplash/domain/model/photos_by_id.dart';
import 'package:unsplash/domain/repository/http_photo_repository.dart';
import '../../resource/photos_res.dart';

class MockService extends Mock implements HttpPhotoRepository {}

class MockDioResponse extends Mock implements Response {}

void main() {
  late MockService mockService;

  setUp(() {
    mockService = MockService();
  });

  test("get photos", () async {
    final response = MockDioResponse();
    when(() => response.statusCode).thenReturn(200);
    when(() => response.data).thenReturn(
      MockResponse.photoRes,
    );
    when(() => mockService.getPhotos(any())).thenAnswer(
        (realInvocation) async => Future.value(
            List<Photos>.from(response.data.map((x) => Photos.fromJson(x)))));
    final res = await mockService.getPhotos(1);
    expect(res, isA<List<Photos>>());
  });

  test("get photos by id", () async {
    final response = MockDioResponse();
    when(() => response.statusCode).thenReturn(200);
    when(() => response.data).thenReturn(
      MockResponse.photoDetails,
    );
    when(() => mockService.photoDetails(any())).thenAnswer(
        (realInvocation) async =>
            Future.value(PhotosbyId.fromJson(response.data)));
    final res = await mockService.photoDetails("wefwfevewerfccv");
    expect(res, isA<PhotosbyId>());
  });

  test("Failed to get photos by id", () async {
    final response = MockDioResponse();
    when(() => response.statusCode).thenReturn(401);
    when(() => mockService.photoDetails(any())).thenThrow(MockResponse.failed);
    final res = MockResponse.failed;
    expect(res, MockResponse.failed);
  });

  test("Failed to get photos", () async {
    final response = MockDioResponse();
    when(() => response.statusCode).thenReturn(401);
    when(() => mockService.getPhotos(any())).thenThrow(MockResponse.failed);
    final res = MockResponse.failed;
    expect(res, MockResponse.failed);
  });
}
