import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:stroi_komf/models/calculator_model.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final Dio dio;

  CalculatorBloc(this.dio) : super(CalculatorInitial()) {
    on<LoadCalculatorData>(_onLoadData);
    on<SelectOption>(_onSelectOption);
  }

  Future<void> _onLoadData(LoadCalculatorData event, Emitter<CalculatorState> emit) async {
    emit(CalculatorLoading());
    try {
      final response = await dio.get(
          'https://raw.githubusercontent.com/Antonvishnar/stroi-komfort/refs/heads/main/calculator.json');

      final data = response.data is String
      ? json.decode(response.data)
      : response.data;

      final sections = (data['sections'] as List)
          .map((e) => CalculatorSection.fromJson(e))
          .toList();
      emit(CalculatorLoaded(sections, {}));
    } catch (e) {
      emit(CalculatorError('Ошибка загрузки данных: $e'));
    }
  }
void _onSelectOption(SelectOption event, Emitter<CalculatorState> emit) {
    if (state is CalculatorLoaded) {
      final current = state as CalculatorLoaded;
      final updated = Map<String, CalculatorOption>.from(current.selectedOptions)
      ..[event.sectionName] = event.selectedOption;
      emit(CalculatorLoaded(current.sections, updated));
    }
}
}