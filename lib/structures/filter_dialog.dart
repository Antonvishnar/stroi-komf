import 'package:flutter/material.dart';
import '../bloc/project_bloc.dart';

class FilterDialog extends StatefulWidget {
  final ProjectBloc projectBloc;
  final Function(double minPrice, double maxPrice, int? floors, double minSquare, double maxSquare) onApply;

  const FilterDialog({super.key, required this.projectBloc, required this.onApply});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _minSquareController = TextEditingController();
  final _maxSquareController = TextEditingController();
  int? _selectedFloors;

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _minSquareController.dispose();
    _maxSquareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Фильтры'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _minPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Мин. цена (₽)'),
            ),
            TextField(
              controller: _maxPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Макс. цена (₽)'),
            ),
            DropdownButton<int?>(
              value: _selectedFloors,
              hint: const Text('Этажей'),
              isExpanded: true,
              items: const [
                DropdownMenuItem<int?>(value: null, child: Text('Любое')),
                DropdownMenuItem<int>(value: 1, child: Text('1 этаж')),
                DropdownMenuItem<int>(value: 2, child: Text('2 этажа')),
                DropdownMenuItem<int>(value: 3, child: Text('3 этажа')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFloors = value;
                });
              },
            ),
            TextField(
              controller: _minSquareController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Мин. площадь (м²)'),
            ),
            TextField(
              controller: _maxSquareController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Макс. площадь (м²)'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            print('FilterDialog: Нажата кнопка Отмена');
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            print('FilterDialog: Нажата кнопка Применить');
            final minPrice = double.tryParse(_minPriceController.text) ?? 0.0;
            final maxPrice = double.tryParse(_maxPriceController.text) ?? double.infinity;
            final minSquare = double.tryParse(_minSquareController.text) ?? 0.0;
            final maxSquare = double.tryParse(_maxSquareController.text) ?? double.infinity;
            print('FilterDialog: Параметры фильтра - minPrice: $minPrice, maxPrice: $maxPrice, floors: $_selectedFloors, minSquare: $minSquare, maxSquare: $maxSquare');
            widget.onApply(minPrice, maxPrice, _selectedFloors, minSquare, maxSquare);
            Navigator.pop(context);
          },
          child: const Text('Применить'),
        ),
      ],
    );
  }
}