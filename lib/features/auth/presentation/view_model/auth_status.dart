import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String? errorMessage;
  final bool isLoading;
  final UserEntity? user;

  const AuthState({this.errorMessage, this.isLoading = false, this.user});

  @override
  List<Object?> get props => [errorMessage, isLoading, user];
  AuthState copyWith({String? errorMessage, bool? isLoading, UserEntity? user}) {
    return AuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}

// class Car extends Equatable {
//   final String id;
//   final String name;

//   const Car({required this.id, required this.name});

//   @override
//   // TODO: implement props
//   List<Object?> get props => [id];
//   copyWith({String? id, String? name}) {
//     return Car(
//       id: id ?? this.id,
//       name: name ?? this.name,
//     );
//   }
// }

// xx() {
//   Car car1 = Car(id: '123', name: 'Toyota');
//   Car car2 = Car(id: '123', name: 'Honda');
//   car1 = car1.copyWith(
//     id: '456',
//   );
//   if (car1 == car2) {
//     print('same');
//   }
// }
