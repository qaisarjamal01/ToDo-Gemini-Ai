import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_gemini_ai/app/presentation/screens/settings_screen.dart';
import 'package:todo_gemini_ai/app/presentation/screens/stats_screen.dart';

import '../../data/models/todo_model.dart';
import '../../data/providers/todo_provider.dart';
import '../widgets/todo_list_item.dart';
import 'add_edit_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        drawer: const AppDrawer(),
        body: const TabBarView(
          children: [
            // All Todos
            TodoListView(filter: 'all'),
            // Pending Todos
            TodoListView(filter: 'pending'),
            // Completed Todos
            TodoListView(filter: 'completed'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddEditTodoScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.show_chart),
            title: const Text('Statistics'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const StatsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TodoListView extends StatelessWidget {
  final String filter;
  const TodoListView({required this.filter, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        List<Todo> todos;
        if (filter == 'pending') {
          todos = todoProvider.pendingTodos;
        } else if (filter == 'completed') {
          todos = todoProvider.completedTodos;
        } else {
          todos = todoProvider.allTodos;
        }

        if (todos.isEmpty) {
          return const Center(child: Text('No todos found.'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoListItem(todo: todos[index]);
            },
          ),
        );
      },
    );
  }
}