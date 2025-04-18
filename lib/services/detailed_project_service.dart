import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stroi_komf/models/model_detailed_project.dart';

class ProjectDetailService {
  static Future<DetailedProject> fetchDetailedProject(String id) async {
    final url = 'https://raw.githubusercontent.com/Antonvishnar/stroi-komfort/refs/heads/main/projects/project_$id.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DetailedProject.fromJson(data);
    }
    else {
      throw Exception('Не удалось загрузить подробности проекта');
    }
  }
}

