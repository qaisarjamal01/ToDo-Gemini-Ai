import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/todo_provider.dart';
import '../widgets/stats_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.allTodos.isEmpty) {
            return const Center(child: Text('No data to display.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category-wise Todos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: CategoryChart(todos: todoProvider.allTodos),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Week-wise Todos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: TimeSeriesChart(
                        todos: todoProvider.allTodos,
                        grouping: TimeGrouping.week),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Month-wise Todos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: TimeSeriesChart(
                        todos: todoProvider.allTodos,
                        grouping: TimeGrouping.month),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}