import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/project_model.dart';

class ProjectService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<Project>> fetchProjects() async {
    const url = 'https://raw.githubusercontent.com/Antonvishnar/stroi-komfort/refs/heads/main/projects.json';
    try {
      print('Отправка запроса к $url');
      final response = await _dio.get(url);
      print('Ответ получен: ${response.statusCode}, данные: ${response.data.runtimeType} - ${response.data}');
      if (response.statusCode == 200) {
        List<dynamic> jsonList;
        if (response.data is String) {
          print('response.data является строкой, парсим JSON');
          jsonList = jsonDecode(response.data) as List<dynamic>;
        } else if (response.data is List<dynamic>) {
          jsonList = response.data;
        } else {
          throw Exception('Неверный формат данных: ожидался List, получен ${response.data.runtimeType}');
        }
        print('Парсинг JSON, количество элементов: ${jsonList.length}');
        return jsonList.map((json) => Project.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка загрузки: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка в ProjectService: $e');
      throw Exception('Не удалось загрузить проекты: $e');
    }
  }
}