import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:widgetbuilder/dropdown_model.dart';
import 'package:widgetbuilder/textfield_model.dart';

class WidgetsBuilderProvider extends ChangeNotifier {
  final List<DropdownModel> _dropdownItems = [];
  List get dropdownItems => _dropdownItems;

  final List<TextFieldModel> _textFields = [];
  List get textFields => _textFields;

  String _f1 = "A";
  String get f1 => _f1;

  Future loadJson({
    required BuildContext context,
  }) async {
    Logger().i("Loading json data");
    try {
      String data =
          await DefaultAssetBundle.of(context).loadString("assets/inputs.json");
      final jsonResult = jsonDecode(data);
      _dropdownItems.clear();
      _textFields.clear();
      for (var item in jsonResult) {
        if (item['widget'] == 'dropdown') {
          _dropdownItems.add(DropdownModel(
              fieldName: item["field_name"],
              validValues: item["valid_values"]));
        } else if (item['widget'] == 'textfield') {
          _textFields.add(TextFieldModel(
              fieldName: item["field_name"], visibility: item["visible"]));
        }
      }
    } catch (e) {
      Logger().e("Error loading json data: $e");
    }
    notifyListeners();
    Logger().i(
        "The json result is: ${_dropdownItems.length} dropdowns and ${_textFields.length} textfields");
  }

  void setF1(String value) {
    _f1 = value;
    notifyListeners();
  }
}

final widgetBuilderProvider = ChangeNotifierProvider<WidgetsBuilderProvider>(
  (ref) => WidgetsBuilderProvider(),
);
