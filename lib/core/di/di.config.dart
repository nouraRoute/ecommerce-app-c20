// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/api/auth_api.dart' as _i302;
import '../../features/auth/data/data_source/auth_data_source.dart' as _i364;
import '../../features/auth/data/repository/auth_repo_impl.dart' as _i751;
import '../../features/auth/domain/repository/auth_repo.dart' as _i976;
import '../../features/auth/domain/usecases/check_logedin_usecase.dart'
    as _i994;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/view_model/auth_cubit.dart' as _i208;
import 'module/dio.module.dart' as _i688;
import 'module/share_prefrance.module.dart' as _i968;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    final sharePreferenceModule = _$SharePreferenceModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharePreferenceModule.sharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i302.AuthApi>(() => _i302.AuthApi(gh<_i361.Dio>()));
    gh.factory<_i364.AuthDataSource>(
        () => _i364.AuthRemoteDataSource(authApi: gh<_i302.AuthApi>()));
    gh.factory<_i976.AuthRepo>(() => _i751.AuthRepoImpl(
          authDataSource: gh<_i364.AuthDataSource>(),
          sharedPreferences: gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i994.CheckLoginUsecase>(
        () => _i994.CheckLoginUsecase(authRepo: gh<_i976.AuthRepo>()));
    gh.factory<_i188.LoginUsecase>(
        () => _i188.LoginUsecase(authRepo: gh<_i976.AuthRepo>()));
    gh.factory<_i941.RegisterUsecase>(
        () => _i941.RegisterUsecase(authRepo: gh<_i976.AuthRepo>()));
    gh.factory<_i208.AuthCubit>(() => _i208.AuthCubit(
          loginUsecase: gh<_i188.LoginUsecase>(),
          registerUsecase: gh<_i941.RegisterUsecase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i688.DioModule {}

class _$SharePreferenceModule extends _i968.SharePreferenceModule {}
