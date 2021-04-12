import 'package:flutter_to_do/@core/data/database/todo.database.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@core/repo/todo/to_do_response.dart';
import 'package:flutter_to_do/@core/services/view_state.service.dart';

class AddItemViewModel extends ViewStateModel {
  DBProvider db = byInject<DBProvider>();

  TodoResponse _modelTodo = TodoResponse();

  TodoResponse get modelTodo => _modelTodo;

  set modelTodo(value) => _modelTodo = value;

  void setValue(String val) {
    _modelTodo.value = int.tryParse(val);
    notifyListeners();
  }

  void setName(String val) {
    _modelTodo.name = val;
    notifyListeners();
  }

  Future<int> addItemTodo(TodoResponse item) async {
    var result = item.name.isNotEmpty ? await db.insert(item) : -1;
    return result;
  }

  Future<int> editItemTodo(TodoResponse item) async {
    var result = await db.update(item);
    return result;
  }
}
