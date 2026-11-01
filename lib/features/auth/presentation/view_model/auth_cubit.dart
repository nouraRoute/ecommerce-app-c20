import 'dart:developer';

import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/view_model/auth_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  AuthCubit({required LoginUsecase loginUsecase, required RegisterUsecase registerUsecase})
      : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase,
        super(const AuthState());

  login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    Response<UserEntity?> response = await _loginUsecase(UserEntity(email: email, password: password));
    switch (response) {
      case Success<UserEntity?>():
        emit(state.copyWith(isLoading: false, user: response.data));
      case Failure<UserEntity?>():
        emit(state.copyWith(isLoading: false, errorMessage: response.errorModel.message));
    }
  }

  register(String name, String email, String password, String phoneNumber) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    Response<UserEntity?> response =
        await _registerUsecase(UserEntity(name: name, email: email, password: password, phoneNumber: phoneNumber));
    switch (response) {
      case Success<UserEntity?>():
        emit(state.copyWith(isLoading: false, user: response.data));
      case Failure<UserEntity?>():
        emit(state.copyWith(isLoading: false, errorMessage: response.errorModel.message));
    }
  }
}
