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
import '../../features/cart/data/api/cart_api.dart' as _i209;
import '../../features/cart/data/data_source/cart_data_source.dart' as _i851;
import '../../features/cart/data/repository/cart_repo_impl.dart' as _i668;
import '../../features/cart/domain/repository/cart_repo.dart' as _i209;
import '../../features/cart/domain/usecases/add_to_cart_usecase.dart' as _i659;
import '../../features/cart/domain/usecases/get_cart_usecase.dart' as _i179;
import '../../features/cart/domain/usecases/remove_from_cart_usecase.dart'
    as _i355;
import '../../features/cart/domain/usecases/update_cart_item_usecase.dart'
    as _i495;
import '../../features/cart/presentation/view_model/cubit/cart_cubit.dart'
    as _i323;
import '../../features/category/data/api/category_api.dart' as _i74;
import '../../features/category/data/data_source/category_data_source.dart'
    as _i484;
import '../../features/category/data/repository/category_repo_impl.dart'
    as _i422;
import '../../features/category/domain/repository/category_repo.dart' as _i408;
import '../../features/category/domain/usecases/get_categories_usecase.dart'
    as _i125;
import '../../features/category/domain/usecases/get_subcategories_usecase.dart'
    as _i562;
import '../../features/category/presentation/view_model/cubit/category_cubit.dart'
    as _i188;
import '../../features/products/data/api/products_api.dart' as _i960;
import '../../features/products/data/data_source/products_data_source.dart'
    as _i861;
import '../../features/products/data/repository/products_repo_impl.dart'
    as _i99;
import '../../features/products/domain/repository/products_repo.dart' as _i466;
import '../../features/products/domain/usecases/get_products_usecase.dart'
    as _i15;
import '../../features/products/presentation/view_model/cubit/products_cubit.dart'
    as _i593;
import 'module/dio.module.dart' as _i688;
import 'module/share_prefrance.module.dart' as _i968;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharePreferenceModule = _$SharePreferenceModule();
    final dioModule = _$DioModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharePreferenceModule.sharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i302.AuthApi>(() => _i302.AuthApi(gh<_i361.Dio>()));
    gh.factory<_i209.CartApi>(() => _i209.CartApi(gh<_i361.Dio>()));
    gh.factory<_i74.CategoryApi>(() => _i74.CategoryApi(gh<_i361.Dio>()));
    gh.factory<_i960.ProductsApi>(() => _i960.ProductsApi(gh<_i361.Dio>()));
    gh.factory<_i851.CartDataSource>(
      () => _i851.CartRemoteDataSource(cartApi: gh<_i209.CartApi>()),
    );
    gh.factory<_i861.ProductsDataSource>(
      () =>
          _i861.ProductsRemoteDataSource(productsApi: gh<_i960.ProductsApi>()),
    );
    gh.factory<_i364.AuthDataSource>(
      () => _i364.AuthRemoteDataSource(authApi: gh<_i302.AuthApi>()),
    );
    gh.factory<_i466.ProductsRepo>(
      () => _i99.ProductsRepoImpl(
        productsDataSource: gh<_i861.ProductsDataSource>(),
      ),
    );
    gh.factory<_i976.AuthRepo>(
      () => _i751.AuthRepoImpl(
        authDataSource: gh<_i364.AuthDataSource>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i484.CategoryDataSource>(
      () => _i484.CategoryRemoteDataSource(categoryApi: gh<_i74.CategoryApi>()),
    );
    gh.factory<_i15.GetProductsUsecase>(
      () => _i15.GetProductsUsecase(productsRepo: gh<_i466.ProductsRepo>()),
    );
    gh.factory<_i209.CartRepo>(
      () => _i668.CartRepoImpl(cartDataSource: gh<_i851.CartDataSource>()),
    );
    gh.factory<_i994.CheckLoginUsecase>(
      () => _i994.CheckLoginUsecase(authRepo: gh<_i976.AuthRepo>()),
    );
    gh.factory<_i188.LoginUsecase>(
      () => _i188.LoginUsecase(authRepo: gh<_i976.AuthRepo>()),
    );
    gh.factory<_i941.RegisterUsecase>(
      () => _i941.RegisterUsecase(authRepo: gh<_i976.AuthRepo>()),
    );
    gh.factory<_i208.AuthCubit>(
      () => _i208.AuthCubit(
        loginUsecase: gh<_i188.LoginUsecase>(),
        registerUsecase: gh<_i941.RegisterUsecase>(),
      ),
    );
    gh.factory<_i593.ProductsCubit>(
      () => _i593.ProductsCubit(
        getProductsUsecase: gh<_i15.GetProductsUsecase>(),
      ),
    );
    gh.factory<_i408.CategoryRepo>(
      () => _i422.CategoryRepoImpl(
        categoryDataSource: gh<_i484.CategoryDataSource>(),
      ),
    );
    gh.factory<_i659.AddToCartUsecase>(
      () => _i659.AddToCartUsecase(cartRepo: gh<_i209.CartRepo>()),
    );
    gh.factory<_i179.GetCartUsecase>(
      () => _i179.GetCartUsecase(cartRepo: gh<_i209.CartRepo>()),
    );
    gh.factory<_i355.RemoveFromCartUsecase>(
      () => _i355.RemoveFromCartUsecase(cartRepo: gh<_i209.CartRepo>()),
    );
    gh.factory<_i495.UpdateCartItemUsecase>(
      () => _i495.UpdateCartItemUsecase(cartRepo: gh<_i209.CartRepo>()),
    );
    gh.lazySingleton<_i323.CartCubit>(
      () => _i323.CartCubit(
        getCartUsecase: gh<_i179.GetCartUsecase>(),
        addToCartUsecase: gh<_i659.AddToCartUsecase>(),
        removeFromCartUsecase: gh<_i355.RemoveFromCartUsecase>(),
        updateCartItemUsecase: gh<_i495.UpdateCartItemUsecase>(),
      ),
    );
    gh.factory<_i125.GetCategoriesUsecase>(
      () => _i125.GetCategoriesUsecase(categoryRepo: gh<_i408.CategoryRepo>()),
    );
    gh.factory<_i562.GetSubcategoriesUsecase>(
      () =>
          _i562.GetSubcategoriesUsecase(categoryRepo: gh<_i408.CategoryRepo>()),
    );
    gh.factory<_i188.CategoryCubit>(
      () => _i188.CategoryCubit(
        getCategoriesUsecase: gh<_i125.GetCategoriesUsecase>(),
        getSubCategoriesUsecase: gh<_i562.GetSubcategoriesUsecase>(),
      ),
    );
    return this;
  }
}

class _$SharePreferenceModule extends _i968.SharePreferenceModule {}

class _$DioModule extends _i688.DioModule {}
