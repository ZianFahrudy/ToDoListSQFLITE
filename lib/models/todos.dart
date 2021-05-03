class Todos {
  int id;
  String title;
  String description;
  String todosDate;
  String category;

  Map<String, dynamic> todoMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['todosDate'] = todosDate;
    map['category'] = category;

    return map;
  }
}
