class Todo {
  String id;
  String name;
  String message;
  String color;
  String country;
  String type;
  bool active;

 Todo({
    required this.id,
    required this.name,
    required this.message,
    required this.color,
    required this.country,
    required this.type,
    required this.active,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      name: json["name"],
      message: json["message"],
      color: json["color"],
      country: json["country"],
      type: json["type"],
      active: json["active"],
    );
  }

  static List<Todo> fromJsonList(List items) {
    return items.map((item) => Todo.fromJson(item)).toList();
  }

  bool isEqual(Todo model) {
    return id == model.id;
  }
}