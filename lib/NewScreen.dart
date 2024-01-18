import 'package:flutter/material.dart';

void main() {
  runApp(const NewScreen());
}

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TASK'),
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink[200]!, Colors.pink[400]!],
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TodoApp(),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TodoList();
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> todos = [];

  TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Todos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoItemWidget(
                todoItem: todos[index],
                onCheckboxChanged: (value) {
                  _updateTodo(index, value);
                },
                onDeletePressed: () {
                  _removeTodo(index);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _todoController,
            decoration: InputDecoration(
              labelText: 'New Todo',
            ),
            onSubmitted: (value) {
              _addTodo();
            },
          ),
        ),
      ],
    );
  }

  void _addTodo() {
    String newTodo = _todoController.text;
    if (newTodo.isNotEmpty) {
      setState(() {
        todos.add(TodoItem(title: newTodo, completed: false));
        _todoController.clear();
      });
    }
  }

  void _removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _updateTodo(int index, bool value) {
    setState(() {
      todos[index] = todos[index].copyWith(completed: value);
    });
  }
}

class TodoItem {
  final String title;
  final bool completed;

  TodoItem({required this.title, required this.completed});

  TodoItem copyWith({String? title, bool? completed}) {
    return TodoItem(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final TodoItem todoItem;
  final ValueChanged<bool> onCheckboxChanged;
  final VoidCallback onDeletePressed;

  TodoItemWidget({
    required this.todoItem,
    required this.onCheckboxChanged,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todoItem.title,
        style: TextStyle(
          decoration: todoItem.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDeletePressed,
      ),
    );
  }
}
