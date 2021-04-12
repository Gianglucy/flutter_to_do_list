class TodoRequest {
  int page;
  int perPage;

  TodoRequest({this.page, this.perPage});

  factory TodoRequest.fromMap(Map<String, dynamic> map) => TodoRequest(
        page: map['page'] as int,
        perPage: map['perPage'] as int,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'page': this.page,
        'perPage': this.perPage,
      };
}
