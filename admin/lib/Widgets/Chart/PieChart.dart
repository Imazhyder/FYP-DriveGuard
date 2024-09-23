import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Piechart extends StatelessWidget {
  const Piechart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25, Color.fromRGBO(9, 0, 136, 1)),
      ChartData('Steve', 38, Color.fromRGBO(147, 0, 119, 1)),
      ChartData('Jack', 34, Color.fromRGBO(228, 0, 124, 1)),
      ChartData('Others', 52, Color.fromRGBO(255, 189, 57, 1))
    ];
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.onSecondary),
      child: SfCircularChart(
        title: const ChartTitle(text: 'Recent Month'),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          // Renders doughnut chart
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
