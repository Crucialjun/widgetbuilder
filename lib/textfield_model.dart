import 'package:equatable/equatable.dart';

class TextFieldModel extends Equatable {
  final String fieldName;
  final String visibility;

  const TextFieldModel({required this.fieldName, required this.visibility});
  
  @override

  List<Object?> get props => [fieldName, visibility];
  
}
