import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/todo_model.dart';
import '../../data/providers/todo_provider.dart';
import '../screens/add_edit_todo_screen.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  const TodoListItem({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (bool? value) {
            Provider.of<TodoProvider>(context, listen: false)
                .toggleTodoStatus(todo.id);
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          'Due: ${DateFormatter.format(todo.dueDate)} - ${todo.category}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddEditTodoScreen(todo: todo),
              ),
            );
          },
        ),
        onLongPress: () {
          // Show a dialog to confirm deletion
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Delete Todo'),
              content: const Text('Are you sure you want to delete this todo?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<TodoProvider>(context, listen: false)
                        .deleteTodo(todo.id);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}