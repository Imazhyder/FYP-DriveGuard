import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatelessWidget {
  const ColumnChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('Jan', 1000),
      _SalesData('Feb', 800),
      _SalesData('Mar', 700),
      _SalesData('Apr', 600),
      _SalesData('May', 800),
      _SalesData('June', 800),
      _SalesData('July', 100),
      _SalesData('Aug', 300),
      _SalesData('Sep', 500),
      _SalesData('Oct', 1000),
      _SalesData('Nov', 600),
      _SalesData('Dec', 600),
    ];
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width / 2,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.onSecondary),
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        // Chart title
        title: const ChartTitle(text: 'Half yearly sales analysis'),
        // Enable legend
        legend: const Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),

        series: <CartesianSeries<_SalesData, String>>[
          ColumnSeries<_SalesData, String>(
            dataSource: data,
            xValueMapper: (_SalesData sales, _) => sales.year,
            yValueMapper: (_SalesData sales, _) => sales.sales,
            name: 'Sales',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
            width: 0.3,
          )
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
