// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculatorOption _$CalculatorOptionFromJson(Map<String, dynamic> json) =>
    CalculatorOption(
      label: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CalculatorOptionToJson(CalculatorOption instance) =>
    <String, dynamic>{'name': instance.label, 'price': instance.price};

CalculatorSection _$CalculatorSectionFromJson(Map<String, dynamic> json) =>
    CalculatorSection(
      name: json['title'] as String,
      options:
          (json['options'] as List<dynamic>)
              .map((e) => CalculatorOption.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CalculatorSectionToJson(CalculatorSection instance) =>
    <String, dynamic>{'title': instance.name, 'options': instance.options};
