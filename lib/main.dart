import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyToDoList(),
    );
  }
}

class MyToDoList extends StatefulWidget {
  @override
  _MyToDoListState createState() => _MyToDoListState();
}

class _MyToDoListState extends State<MyToDoList> {
  final List<String> _ToDoList = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To Do List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _addToDoList,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: _buildToDoList(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: () {},),
            IconButton(icon: Icon(Icons.search), onPressed: () {},),
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  void _addListPopUp(context) {
    final myController = TextEditingController();

    @override
    void dispose() {
      myController.dispose();
      super.dispose();
    }

    Alert(
        context: context,
        title: "Add To Do List:",
        content: Column(
          children: <Widget>[
            TextField(
              controller: myController,
              // decoration: InputDecoration(
              //   icon: Icon(Icons.account_circle),
              //   labelText: 'To Do: ',
              // ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              setState(() {
                _ToDoList.add(myController.text);
              });
              Navigator.pop(context);
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void _addToDoList() {
    _addListPopUp(context);
  }

  Widget _buildToDoList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _ToDoList.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRowToDo(_ToDoList[i], i);
        }
    );
  }

  Widget _buildRowToDo(String ToDoVar, int index) {

    return Column(
      children: [
        ListTile(
            leading: Container(
              width: 30,
              height: 30,
              child: IconButton(
                  icon: Icon(Icons.check_box_outline_blank, size: 10),
                  onPressed: () {
                    setState(() {
                      _promptRemoveTodoItem(index);
                    });
                  }
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey),
            ),
            title: Text(
                ToDoVar
            ),
            onTap: () {
              setState(() {
                _ToDoList[index] = "edited";
              });
            }
        ),
        Divider(),
      ],
    );
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_ToDoList[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      setState(() {
                        _ToDoList.removeAt(index);
                      });
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }
}