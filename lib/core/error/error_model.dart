import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String code;
  final String message;

  const ErrorModel({required this.code, required this.message});

  @override
  List<Object?> get props => [code, message];
}
