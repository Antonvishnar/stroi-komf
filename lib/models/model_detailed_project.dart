class DetailedProject {
  final String id;
  final String name;
  final String description;
  final List<String> gallery;
  final Map<String, String> tabs;

  DetailedProject({
    required this.id,
    required this.name,
    required this.description,
    required this.gallery,
    required this.tabs,
  });

  factory DetailedProject.fromJson(Map<String, dynamic> json) {
    return DetailedProject(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      gallery: List<String>.from(json['gallery']),
      tabs: Map<String, String>.from(json['tabs']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'gallery': gallery,
      'tabs': tabs,
    };
  }
}
