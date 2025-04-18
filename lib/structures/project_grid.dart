import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/project_bloc.dart';
import '../bloc/project_event.dart';
import '../bloc/project_state.dart';
import 'animated_project_card.dart';
import 'filter_dialog.dart';

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final projectBloc = context.read<ProjectBloc>();
    return Expanded(
      child: Column(
        children: [
          // Поиск и фильтр
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (query) {
                    projectBloc.add(SearchProjects(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Поиск',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => FilterDialog(
                      projectBloc: projectBloc,
                      onApply: (minPrice, maxPrice, floors, minSquare, maxSquare) {
                        projectBloc.add(FilterProjects(
                          minPrice: minPrice,
                          maxPrice: maxPrice,
                          floors: floors,
                          minSquare: minSquare,
                          maxSquare: maxSquare,
                        ));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Сетка проектов
          Expanded(
            child: BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProjectLoaded) {
                  final allProjects = state.projects;
                  final filteredProjects = state.filteredProjects;
                  if (allProjects.isEmpty) {
                    return const Center(child: Text('Нет проектов'));
                  }
                  return GridView.builder(
                    key: const ValueKey('project_grid'),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: filteredProjects.length, // Отображаем только отфильтрованные проекты
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];
                      return AnimatedProjectCard(
                        key: ValueKey(project.id),
                        project: project,
                        isVisible: true,
                      );
                    },
                  );
                } else if (state is ProjectError) {
                  return Center(child: Text('Ошибка: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
