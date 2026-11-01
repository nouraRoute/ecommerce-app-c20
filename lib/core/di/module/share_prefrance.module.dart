import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharePreferenceModule {
  @singleton
  @preResolve
  Future<SharedPreferences> sharedPreferences() async => await SharedPreferences.getInstance();
}
