import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      title:'Todo list',
      theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
      home: new TodoList()
   );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  List<String> _todoItems = [];

  void _addTodoItem(String task){
    if(task.length > 0){
        setState((){
            _todoItems.insert(0,task);
        });
      }
  } 
  void  _removeTodoItem(int index){
    setState((){
            _todoItems.removeAt(index);
        });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('No'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('Yes'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new task')
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context); 
              },
              decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            )
          );
        }
      )
    );
  }

  Widget _buildTodoList(){
    return new ListView.builder(
      itemBuilder: (context, index){
        if(index < _todoItems.length) {
          return ListTile(
              title: new Text(_todoItems[index]),
              trailing: IconButton(icon: Icon(Icons.delete), onPressed:()=> _promptRemoveTodoItem(index))
            );
        }
      }, 
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Center(child:  Text("Todo App"))
        ),
        body: _buildTodoList(),
        floatingActionButton: new FloatingActionButton(onPressed: _pushAddTodoScreen, tooltip:'add task', child:new Icon(Icons.add)),
    );
  } 
}
