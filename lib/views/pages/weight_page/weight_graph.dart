import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/types/weight_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';

class WeightGraph extends StatefulWidget {
  const WeightGraph({
    super.key,
    required this.timeSpan
  });

  final GraphTimeSpan timeSpan;

  @override
  State<WeightGraph> createState() => _WeightGraphState();
}

class _WeightGraphState extends State<WeightGraph> {
  final double _borderRadius = 20;

  static const int weekLength = 7;
  static const int monthLength = 31;
  static const int sixMonthsLength = 6 * 31;
  static const int yearLength = 365;

  static const double defaultMinWeight = 0;
  static const double defaultMaxWeight = 1000;

  static const Duration animationDuration = Duration(milliseconds: 500);
  static const Curve animationCurve = Curves.decelerate; 
  static const double barWidth = 5;

  final DateFormat _monthFormatter = DateFormat('MMM d');
  final DateFormat _sixMonthFormatter = DateFormat('MMM');
  final DateFormat _yearFormatter = DateFormat("MMM, ''yy");
  final DateFormat _allTimeFormatter = DateFormat("MMM dd, ''yy");

  GraphTimeSpan _span = GraphTimeSpan.week;

  int _days = 0;
  List<WeightData?> _weightData = List.empty();

  AxisTitles _bottomAxisTitles = const AxisTitles();
  List<LineChartBarData> _barData = List.empty();
  LineTouchData _lineTouchData = const LineTouchData();

  double _minWeight = defaultMinWeight;
  double _maxWeight = defaultMaxWeight;
  double _verticalMargins = 0;

  @override
  Widget build(BuildContext context) {

    _span = widget.timeSpan;

    _days = _getDays();
    _weightData = WeightPageViewModel.getLastNDaysWeightData(_days);
    _bottomAxisTitles = _getBottomAxisTitles();
    _barData = _getBarData();
    _lineTouchData = _getLineTouchData();

    _minWeight = getMinWeight(_weightData);
    _maxWeight = getMaxWeight(_weightData);
    _verticalMargins = (_maxWeight - _minWeight) / 5;

    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
      decoration: BoxDecoration(
        color: ColorPalette.currentColorPalette.primaryBackground,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      constraints: const BoxConstraints(maxHeight: 250),

      child: LineChart(
        LineChartData(
          borderData: FlBorderData(
            show: false,
          ),

          minX: 0,
          maxX: _days.toDouble(),
          minY: double.parse((_minWeight - _verticalMargins).toStringAsFixed(1)),
          maxY: double.parse((_maxWeight + _verticalMargins).toStringAsFixed(1)),

          lineBarsData: _barData,
          lineTouchData: _lineTouchData,
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: false
          ),
          titlesData: FlTitlesData(
            leftTitles: _getLeftAxisTitles(),
            bottomTitles: _bottomAxisTitles,
            rightTitles: _getRightAxisTitles(),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
        duration: animationDuration,
        curve: animationCurve
      )
    );
  }

  int _getDays() {
    switch (_span) {
      case GraphTimeSpan.week:
        return weekLength - 1;
      case GraphTimeSpan.month:
        return monthLength - 1;
      case GraphTimeSpan.sixMonths:
        return sixMonthsLength - 1;
      case GraphTimeSpan.year:
        return yearLength - 1;
      case GraphTimeSpan.allTime:
        int days = 0;
        for(WeightData? element in WeightPageViewModel.currentData) {
          if(element == null) continue;

          int tempDays = Timestamp.now().toDate().difference(element.timestamp.toDate()).inDays;
          if(tempDays > days) {
            days = tempDays;
          }
        }
        return days;
    }
  }

  AxisTitles _getLeftAxisTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (value, meta) {
          return SideTitleWidget(
            axisSide: AxisSide.left,
            child: Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: ColorPalette.currentColorPalette.hintText,
              )
            )
          );
        },
      )
    );
  }

  AxisTitles _getRightAxisTitles() {
    return const AxisTitles(
      axisNameSize: 15,
      axisNameWidget: Text('')
    );
  }

  AxisTitles _getBottomAxisTitles() {
    double interval = 1;
    switch (_span) {
      
      case GraphTimeSpan.week:
        interval = 1;
      case GraphTimeSpan.month:
        interval = 5;
      case GraphTimeSpan.sixMonths:
        interval = _days / 5;
      case GraphTimeSpan.year:
        interval = _days / 5;
      case GraphTimeSpan.allTime:
        interval = _days / 3;
    }

    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: interval,
        getTitlesWidget: ((value, meta) {

          DateTime now = DateTime.now();

          if(value == _days) {
            return bottomLabel('Today');
          }

          switch (_span) {
            case GraphTimeSpan.week:
              int temp = (value.toInt() + DateTime.now().weekday) % 7 + 1;
              return bottomLabel(getWeekDayAbreviation(temp));

            case GraphTimeSpan.month:
              return bottomLabel(_monthFormatter.format(now.subtract(Duration(days: _days - value.toInt()))));

            case GraphTimeSpan.sixMonths:
              return bottomLabel(_sixMonthFormatter.format(now.subtract(Duration(days: _days - value.toInt()))));

            case GraphTimeSpan.year:
              return bottomLabel(_yearFormatter.format(now.subtract(Duration(days: _days - value.toInt()))));

            case GraphTimeSpan.allTime:
              return bottomLabel(_allTimeFormatter.format(now.subtract(Duration(days: _days - value.toInt()))));
          }

        })
      ),
    );
  }

  List<LineChartBarData> _getBarData() {
    return [
      LineChartBarData(
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              ColorPalette.currentColorPalette.primary.withOpacity(0.1),
              ColorPalette.currentColorPalette.secondary.withOpacity(0.2)
            ]
          )
        ),
        isStrokeCapRound: true,
        barWidth: barWidth,
        dotData: const FlDotData(show: false),
        color: ColorPalette.currentColorPalette.primary,
        isCurved: true,
        spots: _getFlSpots())
    ];
  }

  List<FlSpot> _getFlSpots() {
    List<FlSpot> spots = List.empty(growable: true);

    for (int i = 0; i < _days; i += 1) {
      if (_weightData[i] != null) {
        spots.add(FlSpot(i.toDouble(), _weightData[i]!.weight));
      }
    }
    if (WeightPageViewModel.todaysWeightData != null) {
      spots.add(FlSpot(_days.toDouble(), WeightPageViewModel.todaysWeightData!.weight));
    }

    return spots;
  }

  SideTitleWidget bottomLabel(String label) {
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: ColorPalette.currentColorPalette.hintText,
        )
      ),
    );
  }

  String getWeekDayAbreviation(int weekDay) {
    switch(weekDay) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  double getMinWeight(List<WeightData?> data) {
    double minWeight = defaultMinWeight;
    for (WeightData? element in data) {
      if (element != null) {
        if (minWeight == defaultMinWeight) {
          minWeight = element.weight;
        } else if (element.weight < minWeight) {
          minWeight = element.weight;
        }
      }
    }
    return minWeight;
  }

  double getMaxWeight(List<WeightData?> data) {
    double maxWeight = defaultMaxWeight;
    for (WeightData? element in data) {
      if (element != null) {
        if (maxWeight == defaultMaxWeight) {
          maxWeight = element.weight;
        } else if (element.weight > maxWeight) {
          maxWeight = element.weight;
        }
      }
    }
    return maxWeight;
  }
  
  LineTouchData _getLineTouchData() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: ColorPalette.currentColorPalette.secondaryBackground,
        tooltipBorder: BorderSide(
          color: ColorPalette.currentColorPalette.primaryBackground,
        ),
        getTooltipItems: _getTooltipItems
      )
    );
  }

  List<LineTooltipItem> _getTooltipItems(List<LineBarSpot> barSpots) {
    List<LineTooltipItem> items = List.empty(growable: true);

    for(LineBarSpot spot in barSpots) {
      WeightData? curData = _weightData[spot.x.toInt()];
      if(curData != null) {
        items.add(
          LineTooltipItem(
            '${curData.weight.toString()} lbs\n',
            TextStyle(
              color: ColorPalette.currentColorPalette.text
            ),
            children: [
              TextSpan(
                text: _allTimeFormatter.format(curData.timestamp.toDate()),
                style: TextStyle(
                  color: ColorPalette.currentColorPalette.hintText
                )
              )
            ]
          )
        );
      }
    }

    return items;
  }
}
