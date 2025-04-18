import 'package:equatable/equatable.dart';
import 'package:stroi_komf/models/calculator_model.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];

}

class LoadCalculatorData extends CalculatorEvent {}

class SelectOption extends CalculatorEvent {
  final String sectionName;
  final CalculatorOption selectedOption;

  const SelectOption(this.sectionName, this.selectedOption);

  @override

  List<Object> get props => [sectionName, selectedOption];

}
