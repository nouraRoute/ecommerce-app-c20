import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;

  const BrandEntity({this.id, this.name, this.image});

  @override
  List<Object?> get props => [id, name, image];
}
