import 'dart:developer';

import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/view_model/auth_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUsecase;
  AuthCubit({required LoginUsecase loginUsecase})
      : _loginUsecase = loginUsecase,
        super(AuthInitialStatus());

  login(String email, String password) async {
    emit(LoginLoadingStatus());
    Response<UserEntity?> response = await _loginUsecase(UserEntity(email: email, password: password));
    switch (response) {
      case Success<UserEntity?>():
        emit(LoginSuccessStatus());
      case Failure<UserEntity?>():
        emit(LoginErrorStatus(errorMessage: response.errorModel.message));
    }
  }
}
