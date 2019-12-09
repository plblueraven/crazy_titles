import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  DateTime startDate = DateTime.now();

  List<FlSpot> x = [
    FlSpot(0.01, 0.1),
    FlSpot(1.01, 0.2),
    FlSpot(2.01, -0.1),
    FlSpot(3.01, 0.3),
    FlSpot(4.01, -0.2),
    FlSpot(6, -0.2),
  ];

  double maxArg = 0.5;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    const oneDecimal = const Duration(milliseconds: 130);
    _timer = new Timer.periodic(oneDecimal, (Timer timer) {
      var secondsFromStart =
          DateTime.now().difference(startDate).inMilliseconds.toDouble() / 1000;
      setState(() {
        maxArg = secondsFromStart;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 12),
                Text(
                  'Crazy titles',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.button.color,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                      child: LineChart(sampleData1())),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).hintColor.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            textStyle: TextStyle(
              color: Theme.of(context).textTheme.button.color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            margin: 10,
            interval: maxArg > 2
                ? () {
                    var half = (maxArg / 2);
                    var floor = half.floor();
                    var floorDouble = floor;
                    print(
                        "half: $half, floor: $floor, floor double: $floorDouble");
                    return floorDouble;
                  }()
                : 2),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Theme.of(context).textTheme.button.color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).textTheme.button.color,
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      maxX: maxArg,
      minX: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: x,
      barWidth: 1,
      //preventCurveOverShooting: true,
      //isCurved: true,
      colors: [
//        Theme.of(context).hintColor,
        Colors.white,
      ],
      //isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [lineChartBarData1];
  }
}
