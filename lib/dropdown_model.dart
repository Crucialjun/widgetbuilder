import 'package:equatable/equatable.dart';

class DropdownModel extends Equatable {
  final String fieldName;
  final List<dynamic> validValues;

  const DropdownModel({required this.fieldName, required this.validValues});

  @override
  List<Object?> get props => [fieldName, validValues];
}
