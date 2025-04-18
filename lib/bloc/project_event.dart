import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProjects extends ProjectEvent {}

class SearchProjects extends ProjectEvent {
  final String query;

  SearchProjects(this.query);

  @override
  List<Object> get props => [query];
}

class FilterProjects extends ProjectEvent {
  final double minPrice;
  final double maxPrice;
  final int? floors;
  final double minSquare;
  final double maxSquare;

  FilterProjects({
    required this.minPrice,
    required this.maxPrice,
    this.floors,
    required this.minSquare,
    required this.maxSquare,
  });

  @override
  List<Object> get props => [minPrice, maxPrice, floors ?? 0, minSquare, maxSquare];
}