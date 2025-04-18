import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';
import 'project_event.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectService projectService;
  String _lastQuery = '';
  double _minPrice = 0.0;
  double _maxPrice = double.infinity;
  int? _floors;
  double _minSquare = 0.0;
  double _maxSquare = double.infinity;

  ProjectBloc(this.projectService) : super(ProjectInitial()) {
    on<FetchProjects>(_onFetchProjects);
    on<SearchProjects>(_onSearchProjects);
    on<FilterProjects>(_onFilterProjects);
  }

  Future<void> _onFetchProjects(FetchProjects event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    try {
      print('ProjectBloc: Начало загрузки проектов');
      final projects = await projectService.fetchProjects();
      print('ProjectBloc: Проекты загружены, количество: ${projects.length}');
      emit(ProjectLoaded(
        projects: projects,
        filteredProjects: _applyFilters(
          projects,
          _lastQuery,
          _minPrice,
          _maxPrice,
          _floors,
          _minSquare,
          _maxSquare,
        ),
      ));
    } catch (e) {
      print('Ошибка в ProjectBloc: $e');
      emit(ProjectError('Не удалось загрузить проекты: $e'));
    }
  }

  void _onSearchProjects(SearchProjects event, Emitter<ProjectState> emit) {
    if (state is ProjectLoaded) {
      final currentState = state as ProjectLoaded;
      _lastQuery = event.query;
      emit(ProjectLoaded(
        projects: currentState.projects,
        filteredProjects: _applyFilters(
          currentState.projects,
          _lastQuery,
          _minPrice,
          _maxPrice,
          _floors,
          _minSquare,
          _maxSquare,
        ),
      ));
    }
  }

  void _onFilterProjects(FilterProjects event, Emitter<ProjectState> emit) {
    if (state is ProjectLoaded) {
      final currentState = state as ProjectLoaded;
      _minPrice = event.minPrice;
      _maxPrice = event.maxPrice;
      _floors = event.floors;
      _minSquare = event.minSquare;
      _maxSquare = event.maxSquare;
      emit(ProjectLoaded(
        projects: currentState.projects,
        filteredProjects: _applyFilters(
          currentState.projects,
          _lastQuery,
          _minPrice,
          _maxPrice,
          _floors,
          _minSquare,
          _maxSquare,
        ),
      ));
    }
  }

  List<Project> _applyFilters(
      List<Project> projects,
      String query,
      double minPrice,
      double maxPrice,
      int? floors,
      double minSquare,
      double maxSquare,
      ) {
    return projects.where((project) {
      final matchesQuery = query.isEmpty || project.name.toLowerCase().contains(query.toLowerCase());
      final matchesPrice = project.price >= minPrice && project.price <= maxPrice;
      final matchesFloors = floors == null || project.floors == floors;
      final matchesSquare = project.square >= minSquare && project.square <= maxSquare;
      return matchesQuery && matchesPrice && matchesFloors && matchesSquare;
    }).toList();
  }
}