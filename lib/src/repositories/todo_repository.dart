import 'package:bloc_casestudy/src/models/todo_model.dart';

class TodoRepository {
  final List<TodoModel> _todos = [];

  Future<List<TodoModel>> getTodos() async {
    _todos.addAll([
      TodoModel(name: 'Estudar BloC'),
      TodoModel(name: 'Estudar GoLang'),
      TodoModel(name: 'Fazer compras do mês'),
      TodoModel(name: 'Ir a academia')
    ]);

    return Future.delayed(const Duration(seconds: 2), () => _todos);
  }

  Future<List<TodoModel>> removeTodo({required TodoModel todo}) async {
    _todos.remove(todo);

    return Future.delayed(const Duration(seconds: 2), () => _todos);
  }

  Future<List<TodoModel>> postTodo({required TodoModel todo}) async {
    _todos.add(todo);

    return Future.delayed(const Duration(seconds: 2), () => _todos);
  }
}