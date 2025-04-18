import 'package:equatable/equatable.dart';
import 'package:stroi_komf/models/calculator_model.dart';

abstract class CalculatorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoading extends CalculatorState {}

class CalculatorLoaded extends CalculatorState {
  final List<CalculatorSection> sections;
  final Map<String, CalculatorOption> selectedOptions;

  CalculatorLoaded(this.sections, this.selectedOptions);

  double get totalPrice => selectedOptions.values.map((o) => o.price).fold(0, (a, b) => a + b);

  @override
  List<Object?> get props => [sections, selectedOptions];
}

class CalculatorError extends CalculatorState {
  final String message;

  CalculatorError(this.message);

  @override
    List<Object?> get props => [message];
}