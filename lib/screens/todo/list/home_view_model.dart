import 'package:flutter_to_do/@core/data/database/todo.database.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@core/repo/todo/to_do_response.dart';
import 'package:flutter_to_do/@core/services/log.service.dart';
import 'package:flutter_to_do/@core/services/view_state.service.dart';

class HomeViewModel extends ViewStateModel {
  DBProvider db = byInject<DBProvider>();

  List<TodoResponse> _listTodo = [];

  List<TodoResponse> get listTodo => _listTodo;

  void getListTodo() async {
    var list = await db.getListTodo();
    // if (list.isNotEmpty) {
      _listTodo = list;
      notifyListeners();
    // }
  }

  void addTodo() async {
    var countItem = _listTodo.length + 1;
    var count = await db.insert(TodoResponse(
      id: countItem,
      name: "Todo $countItem",
      value: countItem * 100,
    ));
    AppLogger.d(count);
    getListTodo();
  }

  Future<int> deleteTodo(TodoResponse item) async {
    var result = await db.delete(item.id);
    if (result != 0) getListTodo();
    return result;
  }
}
