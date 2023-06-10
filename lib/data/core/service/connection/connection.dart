import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> checkInternet() async {
  try {
    final res = await InternetConnectionChecker().hasConnection;
    return res;
  } catch (e) {
    throw e.toString();
  }
}
