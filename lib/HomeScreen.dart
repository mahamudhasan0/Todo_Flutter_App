import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
  TextEditingController();

  List<Todo> todos = [];
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
            IconButton(
              onPressed: () {
                todos.clear();
                if (mounted) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.playlist_remove),
            )
          ],
        ),
        body: ListView.separated(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                setState(() {
                  todos[index].isDone = !todos[index].isDone;
                });
              },
              leading: todos[index].isDone
                  ? const Icon(Icons.done_all_rounded)
                  : const Icon(Icons.close),
              title: Text(todos[index].title),
              subtitle: Text(
                todos[index].description,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_forever_outlined),
                    onPressed: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _titleTEController.text = todos[index].title;
                      _descriptionTEController.text = todos[index].description;
                      showEditTodoModalSheet(context, index);
                    },
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddNewTodoModalSheet();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void showAddNewTodoModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.person, size: 100, color: Colors.green),
              const Text('Add New Todo'),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _titleTEController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptionTEController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    if (_titleTEController.text.trim().isNotEmpty &&
                        _descriptionTEController.text.trim().isNotEmpty) {
                      setState(() {
                        todos.add(Todo(
                          _titleTEController.text.trim(),
                          _descriptionTEController.text.trim(),
                          false,
                        ));
                      });
                      _titleTEController.clear();
                      _descriptionTEController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showEditTodoModalSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.person, size: 100, color: Colors.green),
              const Text('Edit Todo'),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _titleTEController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptionTEController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
                maxLines: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    if (_titleTEController.text.trim().isNotEmpty &&
                        _descriptionTEController.text.trim().isNotEmpty) {
                      setState(() {
                        todos[index].title = _titleTEController.text.trim();
                        todos[index].description =
                            _descriptionTEController.text.trim();
                      });
                      _titleTEController.clear();
                      _descriptionTEController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Todo {
  String title, description;
  bool isDone;

  Todo(this.title, this.description, this.isDone);
}
