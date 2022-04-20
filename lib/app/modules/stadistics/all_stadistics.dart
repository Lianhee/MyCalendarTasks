import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

getAllProgress(
    {required List<List<int>> sizes,
    // required bool isEmpty,
    // required colors,
    required List<String> titles}) {
  return Row(mainAxisSize: MainAxisSize.min, children: [
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        barProgress(
          //  colors: colors,
          sizes: sizes,
          titles: titles,
          //  isEmpty: isEmpty,
        )
      ],
    ),
  ]);
}

barProgress({required List<List<int>> sizes, required List<String> titles}) {
  final List<BarChartData> chartData = [
    if (sizes.isEmpty)
      for (int i = 0; i < titles.length; i++)
        BarChartData(
          titles[i],
          1,
        )
    else
      for (int i = 0; i < titles.length; i++)
        BarChartData(
          titles[i],
          sizes[i][0].toDouble(),
        )
  ];

  return Center(
      child: SizedBox(
    width: 350,
    height: 194,
    child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        margin: const EdgeInsets.all(5),
        series: <BarSeries<BarChartData, String>>[
          // Render pie chart

          BarSeries<BarChartData, String>(
              color: Colors.deepPurple.shade300,
              dataSource: chartData,
              //  pointColorMapper: (BarChartData data, _) => data.color,
              xValueMapper: (BarChartData data, _) => data.title,
              yValueMapper: (BarChartData data, _) => data.y)
        ]),
  ));
}

class BarChartData {
  BarChartData(this.title, this.y);
  final String title;
  final double y;
}
