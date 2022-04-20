import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:syncfusion_flutter_gauges/gauges.dart';

getPriorityProgress(
    {required List<List<int>> sizes,
    required bool isEmpty,
    required colors,
    required titles}) {
  return Row(mainAxisSize: MainAxisSize.min, children: [
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        pieProgress(
          colors: colors,
          sizes: sizes,
          titles: titles,
          isEmpty: isEmpty,
        )
      ],
    ),
  ]);
}

radialProgress({
  required int priority,
  required List<int> sizes,
  required Color color,
  required String title,
}) {
  return SizedBox(
      height: 48,
      width: 172,
      child: Row(children: [
        SizedBox(
          width: 40,
          height: 40,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: 0,
                  maximum: sizes[1].toDouble() > 0 ? sizes[1].toDouble() : 1,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.2,
                    cornerStyle: CornerStyle.bothCurve,
                    color: color.withOpacity(0.25),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: sizes[0].toDouble(),
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: color,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        positionFactor: 0.1,
                        angle: 90,
                        widget: Text(
                          '${sizes[0]} / ${sizes[1]}',
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal),
                        ))
                  ])
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ]));
}

pieProgress(
    {required List<Color> colors,
    required List<List<int>> sizes,
    required List<String> titles,
    required bool isEmpty}) {
  final List<ChartData> chartData = [
    if (isEmpty)
      for (int i = 0; i < 4; i++) ChartData(titles[i], 1, colors[i])
    else
      for (int i = 0; i < 4; i++) ChartData(titles[i], sizes[i][0], colors[i])
  ];

  return Center(
      child: SizedBox(
    width: 350,
    height: 194,
    child: charts.SfCircularChart(
        legend: charts.Legend(
          isVisible: true,
          position: charts.LegendPosition.left,
        ),
        margin: const EdgeInsets.all(5),
        series: <charts.CircularSeries>[
          // Render pie chart

          charts.PieSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.title,
              yValueMapper: (ChartData data, _) => data.y)
        ]),
  ));
}

class ChartData {
  ChartData(this.title, this.y, this.color);
  final String title;
  final int y;
  final Color color;
}
