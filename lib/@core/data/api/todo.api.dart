import 'package:flutter_to_do/@core/repo/todo/to_do_request.dart';
import 'package:flutter_to_do/@core/repo/todo/to_do_response.dart';
import 'package:retrofit/retrofit.dart';

abstract class TodoApi {
  @GET('/getListTodo')
  Future<TodoResponse> getListTodo(@Body() TodoRequest request);

  @POST('/deleteTodo')
  Future<TodoResponse> deleteTodo(@Body() TodoRequest request);

  @POST('/updateTodo')
  Future<TodoResponse> updateTodo(@Body() TodoRequest request);

  @POST('/addTodo')
  Future<TodoResponse> addTodo(@Body() TodoRequest request);
}
