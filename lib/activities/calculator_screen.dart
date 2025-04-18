import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator/calculator_bloc.dart';
import '../bloc/calculator/calculator_event.dart';
import '../bloc/calculator/calculator_state.dart';
import '../models/calculator_model.dart';
import 'package:dio/dio.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State <CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final CalculatorBloc _calculatorBloc;

  @override
  void initState() {
    super.initState();
    _calculatorBloc = CalculatorBloc(Dio());
    _calculatorBloc.add(LoadCalculatorData());
  }

@override
  void dispose() {
    _calculatorBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор стоимости')),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        bloc: _calculatorBloc,
        builder: (context, state) {
          if (state is CalculatorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CalculatorError) {
            return Center(child: Text(state.message));
          } else if (state is CalculatorLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.sections.length,
                    itemBuilder: (context, index) {
                      final section = state.sections[index];
                      final selected = state.selectedOptions[section.name];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(section.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              ...section.options.map((option) {
                                return RadioListTile<CalculatorOption>(
                                  title:
                                  Text('${option.label} (+${option.price}₽)'),
                                  value: option,
                                  groupValue: selected,
                                  onChanged: (_) {
                                    _calculatorBloc.add(
                                      SelectOption(section.name, option),
                                    );
                                  },
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Итого: ${state.totalPrice}₽',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
