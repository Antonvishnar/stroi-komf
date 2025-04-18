import 'package:flutter/material.dart';
import 'package:stroi_komf/models/model_detailed_project.dart';
import 'package:stroi_komf/models/project_model.dart';
import 'package:stroi_komf/services/detailed_project_service.dart';

class ProjectDetailPage extends StatefulWidget {
  final Project project;

  const ProjectDetailPage({
    super.key,
    required this.project
  });

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

  class _ProjectDetailPageState extends State<ProjectDetailPage> {
    late Future<DetailedProject> _detailedProjectFuture;


    @override
    void initState() {
      super.initState();
      _detailedProjectFuture = ProjectDetailService.fetchDetailedProject(widget.project.id);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.project.name)),
        body: FutureBuilder<DetailedProject>(
            future: _detailedProjectFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Нет данных'));
              }

              final project = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ГАЛЕРЕЯ ИЗОБРАЖЕНИЙ
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: project.gallery.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(project.gallery[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16,),

                  //ВКЛАДКИ (Tabs)
                  Expanded(
                    child: DefaultTabController(
                        length: project.tabs.length,
                        child: Column(
                          children: [
                            TabBar(
                              isScrollable: true,
                              tabs: project.tabs.keys
                                .map((title) => Tab(text: title))
                                .toList(),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: project.tabs.values
                                    .map((context) => Padding(
                                      padding:const EdgeInsets.all(16),
                                      child: Text(context),
                                      ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),
                ],
              );
            },
        ),
      );
    }
  }
