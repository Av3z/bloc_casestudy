import 'package:bloc/bloc.dart';
import 'package:bloc_casestudy/src/models/todo_model.dart';
import 'package:bloc_casestudy/src/pages/bloc/todo_event.dart';
import 'package:bloc_casestudy/src/pages/bloc/todo_state.dart';
import 'package:bloc_casestudy/src/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final _todoRepository = TodoRepository();


  TodoBloc() : super(TodoInitialState()){
    on(_mapEventToState);
  }

  void _mapEventToState(TodoEvent event, Emitter emit) async{
    List<TodoModel> todos = [];

    emit(TodoLoadingState());

    if(event is GetTodos) todos = await _todoRepository.getTodos();
    if(event is PostTodos) todos = await _todoRepository.postTodo(todo: event.todo);
    if(event is DeleteTodo) todos = await _todoRepository.removeTodo(todo: event.todo);

    emit(TodoLoadedState(todo: todos));
  }
}