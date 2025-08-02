import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/models/todo_model.dart';
import '../../data/providers/todo_provider.dart';

// Helper function to get color for a category
Color _getCategoryColor(BuildContext context, String categoryName) {
  final category =
  Provider.of<TodoProvider>(context, listen: false).categories.firstWhere(
        (cat) => cat.name == categoryName,
    orElse: () =>
    Provider.of<TodoProvider>(context, listen: false).categories.first,
  );
  return category.color;
}

class CategoryChart extends StatelessWidget {
  final List<Todo> todos;

  const CategoryChart({required this.todos, super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> categoryCounts = {};
    for (var todo in todos) {
      categoryCounts[todo.category] =
          (categoryCounts[todo.category] ?? 0) + 1;
    }

    final List<PieChartSectionData> sections = categoryCounts.entries.map((entry) {
      return PieChartSectionData(
        color: _getCategoryColor(context, entry.key),
        value: entry.value.toDouble(),
        title: entry.value.toString(),
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );
    }).toList();

    return Column(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              pieTouchData: PieTouchData(enabled: true),
            ),
          ),
        ),
        // Legend
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: categoryCounts.entries.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: _getCategoryColor(context, entry.key),
                ),
                const SizedBox(width: 4),
                Text('${entry.key}: ${entry.value}'),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

enum TimeGrouping { week, month }

class TimeSeriesChart extends StatelessWidget {
  final List<Todo> todos;
  final TimeGrouping grouping;

  const TimeSeriesChart({required this.todos, required this.grouping, super.key});

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, int> data = {};
    for (var todo in todos) {
      DateTime key;
      if (grouping == TimeGrouping.week) {
        key = DateTime(todo.dueDate.year, todo.dueDate.month,
            todo.dueDate.day - todo.dueDate.weekday + 1);
      } else {
        key = DateTime(todo.dueDate.year, todo.dueDate.month, 1);
      }
      data[key] = (data[key] ?? 0) + 1;
    }

    final List<FlSpot> spots = data.entries.map((entry) {
      return FlSpot(entry.key.millisecondsSinceEpoch.toDouble(), entry.value.toDouble());
    }).toList();

    // Sort spots by date
    spots.sort((a, b) => a.x.compareTo(b.x));

    final double minX = spots.isNotEmpty ? spots.first.x : 0;
    final double maxX = spots.isNotEmpty ? spots.last.x : 1;
    final double maxY = spots.isNotEmpty
        ? spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b)
        : 1;

    return LineChart(
      LineChartData(
        minX: minX,
        maxX: maxX,
        minY: 0,
        maxY: maxY + 1,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                final formattedDate =
                grouping == TimeGrouping.week ? DateFormat('MM-dd').format(date) : DateFormat('MMM yyyy').format(date);
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                if (value.toInt() == value) {
                  return Text(value.toInt().toString(), style: const TextStyle(fontSize: 10));
                }
                return const Text('');
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.3),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}