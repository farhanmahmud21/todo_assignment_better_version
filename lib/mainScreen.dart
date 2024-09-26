import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_final/todo.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  List<To_do> todo = [
    To_do(title: 'Task Name', description: 'Description', isDone: false)
  ];
  GlobalKey<FormState> todoForm = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // ignore: non_constant_identifier_names
  void _show_Sheet() {
    showModalBottomSheet(
      backgroundColor: Colors.amber,
      context: context,
      builder: (context) => Form(
        key: todoForm,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Add Task'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  label: Text('Title'),
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid, width: 10),
                  ),
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your title';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  contentPadding: EdgeInsets.all(50),
                  label: Text('Description'),
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your title';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    if (todoForm.currentState!.validate()) {
                      todo.add(To_do(
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          isDone: false));
                      if (mounted) {
                        setState(() {});
                      }
                      Navigator.pop(context);

                      _titleController.clear();
                      _descriptionController.clear();
                    }
                  },
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime,
          title: const Text('Task Management'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _show_Sheet();

            if (mounted) {
              setState(() {});
            }
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
                  height: 4,
                  color: Color.fromARGB(255, 22, 28, 148),
                ),
            itemCount: todo.length,
            itemBuilder: (context, index) => ListTile(
                  onLongPress: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.amber,
                      context: context,
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Text('Text Details'),
                              const SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  todo[index].title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  todo[index].description,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.limeAccent),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {});
                                    }
                                    todo.removeAt(index);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: const Color.fromARGB(255, 205, 237, 78),
                  title: Text(todo[index].title),
                  contentPadding: EdgeInsets.all(5),
                  titleAlignment: ListTileTitleAlignment.top,
                  titleTextStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  subtitle: Text(todo[index].description),
                  subtitleTextStyle: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 36, 2, 205)),
                )));
  }
}
