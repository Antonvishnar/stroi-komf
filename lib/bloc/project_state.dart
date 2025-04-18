import 'package:equatable/equatable.dart';
import 'package:stroi_komf/models/project_model.dart';

abstract class ProjectState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<Project> projects;
  final List<Project> filteredProjects;

  ProjectLoaded({
  required this.projects,
    this.filteredProjects = const []
});

  @override
  List<Object> get props => [projects, filteredProjects];
}

class ProjectError extends ProjectState {
  final String message;

  ProjectError(this.message);

  @override
  List<Object> get props => [message];
}
