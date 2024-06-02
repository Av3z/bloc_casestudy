import 'package:bloc_casestudy/src/models/todo_model.dart';
import 'package:bloc_casestudy/src/pages/bloc/todo_bloc.dart';
import 'package:bloc_casestudy/src/pages/bloc/todo_event.dart';
import 'package:bloc_casestudy/src/pages/bloc/todo_state.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TodoBloc _todoBloc;

  @override
  void initState() {
    super.initState();
    _todoBloc = TodoBloc();
    _todoBloc.inputTodo.add(GetTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: const Text('Home'),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _todoBloc.inputTodo.add(PostTodos(todo: TodoModel(name: 'Fazendo teste.')))),
      body: StreamBuilder(
        stream: _todoBloc.outputTodo, 
        builder: (context, state) {
          if(state.data is TodoLoadingState) return const Center(child: CircularProgressIndicator(),);
          if(state.data is TodoLoadedState) {
            final list = state.data?.todos ?? [];
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(list[index].name), 
                  trailing: IconButton(
                    onPressed: () => _todoBloc.inputTodo.add(DeleteTodo(todo: list[index])),
                    icon: const Icon(Icons.delete)),);
            },);
          }
          return Container();
        },)
    );
  }

  @override
  void dispose() {
    _todoBloc.inputTodo.close();
    super.dispose();
  }
}