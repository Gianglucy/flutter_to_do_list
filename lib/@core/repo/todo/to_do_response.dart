class TodoResponse {
  int id;
  String name;
  int value;

  TodoResponse({this.id = 0, this.name = "", this.value = 0});

  factory TodoResponse.fromJson(Map<String, dynamic> json) => TodoResponse(
        id: json['id'] as int,
        value: json['value'] as int,
        name: json['name'] as String,
      );

  List<TodoResponse> getListFromJson(List<dynamic> list) {
    return list.map((e) => TodoResponse.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'value': this.value,
        'name': this.name,
      };
}
