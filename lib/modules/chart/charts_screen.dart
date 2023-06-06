import 'package:flutter/material.dart';
import 'package:flutter_fuzzy/network/fetch_json_data.dart';
import 'package:flutter_fuzzy/themes/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  Widget build(BuildContext context) {
    List<DataPoint> data = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuzzy Logic Control'),
        centerTitle: true,
        backgroundColor: AppColors.APP_PRIMARY_BUTTON,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              // print(listData[0].v1 * 1.0);
              // print(listData[1].v2 * 1.0);
              // print(listData[2].dateTime);
              print(listData.length);
              for (int i = 0; i < listData.length - 1; i = i + 3) {
                data.add(
                  DataPoint(
                    listData[i + 2].dateTime,
                    listData[i + 1].v2 * 1.0,
                    listData[i].v1 * 1.0,
                  ),
                );
              }

              return SfCartesianChart(
                tooltipBehavior: TooltipBehavior(
                  tooltipPosition: TooltipPosition.pointer,
                ),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: CategoryAxis(minimum: 0, maximum: 100),
                series: <ChartSeries>[
                  SplineSeries<DataPoint, String>(
                    dataSource: data,
                    xValueMapper: (DataPoint data, _) => data.x,
                    yValueMapper: (DataPoint data, _) => data.y1,
                    markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                  LineSeries<DataPoint, String>(
                    dataSource: data,
                    xValueMapper: (DataPoint data, _) => data.x,
                    yValueMapper: (DataPoint data, _) => data.y2,
                    markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(strokeAlign: 3),
              );
            }
          },
        ),
      ),
    );
  }
}

class DataPoint {
  final String x;
  final double y1;
  final double y2;

  DataPoint(this.x, this.y1, this.y2);
}
