import 'package:json_annotation/json_annotation.dart';

part 'calculator_model.g.dart';

@JsonSerializable()
class CalculatorOption {
  @JsonKey(name: 'name')
  final String label;
  final double price;

  CalculatorOption({required this.label, required this.price});

  factory CalculatorOption.fromJson(Map<String, dynamic> json) =>
      _$CalculatorOptionFromJson(json);

  Map<String, dynamic> toJson() => _$CalculatorOptionToJson(this);
}

@JsonSerializable()
class CalculatorSection {
  @JsonKey(name: 'title')
  final String name;
  final List<CalculatorOption> options;

  CalculatorSection({required this.name, required this.options});

  factory CalculatorSection.fromJson(Map<String, dynamic> json) =>
      _$CalculatorSectionFromJson(json);

  Map<String, dynamic> toJson() => _$CalculatorSectionToJson(this);
}