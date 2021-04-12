import 'package:flutter_to_do/@core/data/api/todo.api.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@core/repo/todo/to_do_request.dart';
import 'package:flutter_to_do/@core/repo/todo/to_do_response.dart';

import '../base_response.dart';

class TodoRepo {
  TodoApi apiClient = byInject<TodoApi>();

  Future<TodoResponse> getListTodo(TodoRequest request) async {
    try {
      return await apiClient.getListTodo(request);
    } catch (ex) {
      // return ErrorResponse.fromException(ex);
      return ex;
    }
  }
  Future<TodoResponse> addTodo(TodoRequest request) async {
    try {
      return await apiClient.getListTodo(request);
    } catch (ex) {
      // return ErrorResponse.fromException(ex);
      return ex;
    }
  }

  Future<TodoResponse> updateTodo(TodoRequest request) async {
    try {
      return await apiClient.getListTodo(request);
    } catch (ex) {
      // return ErrorResponse.fromException(ex);
      return ex;
    }
  }
}
