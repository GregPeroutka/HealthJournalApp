import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/types/weight_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';

class WeightGraph extends StatefulWidget {
  final WeightPageViewModel weightPageViewModel;

  const WeightGraph({
    super.key,
    required this.weightPageViewModel
  });

  @override
  State<WeightGraph> createState() => _WeightGraphState();
}

class _WeightGraphState extends State<WeightGraph> {
  late final StreamSubscription _onDataUpdatedSubscription;
  
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

  int _days = 0;
  List<WeightData?> _weightData = List.empty();

  AxisTitles _bottomAxisTitles = const AxisTitles();
  List<LineChartBarData> _barData = List.empty();
  LineTouchData _lineTouchData = const LineTouchData();

  double _minWeight = defaultMinWeight;
  double _maxWeight = defaultMaxWeight;
  double _verticalMargins = 0;
  
  GraphTimeSpan _graphTimeSpan = GraphTimeSpan.week;

  @override
  void initState() {
    _onDataUpdatedSubscription = widget.weightPageViewModel.onDataUpdatedBroadcastStream.listen((event) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _onDataUpdatedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _days = _getDays();
    _weightData = widget.weightPageViewModel.getLastNDaysWeightData(_days);
    _bottomAxisTitles = _getBottomAxisTitles();
    _barData = _getBarData();
    _lineTouchData = _getLineTouchData();

    _minWeight = getMinWeight(_weightData);
    _maxWeight = getMaxWeight(_weightData);
    _verticalMargins = (_maxWeight - _minWeight) / 5;

    return Column(
      children: [
        _dropDown(),
        _lineChart(),
      ],
    );
  }

  Align _dropDown() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: AppStyle.currentStyle.padding,
          top: AppStyle.currentStyle.padding),
        height: 36,
        decoration: BoxDecoration(
          color: AppStyle.currentStyle.backgroundColor1,
          borderRadius: BorderRadius.circular(AppStyle.currentStyle.completelyRoundRadius)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: DropdownButton<GraphTimeSpan>(

            value: _graphTimeSpan,
            items: const [

              DropdownMenuItem(
                value: GraphTimeSpan.week, 
                child: Text('Last Week')
              ),
              DropdownMenuItem(
                value: GraphTimeSpan.month, 
                child: Text('Last Month')
              ),
              DropdownMenuItem(
                value: GraphTimeSpan.sixMonths, 
                child: Text('Last 6 Months')
              ),
              DropdownMenuItem(
                value: GraphTimeSpan.year, 
                child: Text('Last year')
              ),
              DropdownMenuItem(
                value: GraphTimeSpan.allTime,
                child: Text('All Time')
              ),

            ],
        
            style: TextStyle(
              color: AppStyle.currentStyle.textColor1,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: "Rubik",
            ),
            dropdownColor: AppStyle.currentStyle.backgroundColor2,
            borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.squareBorderRadius)),
            underline: const SizedBox(),
            isExpanded: false,
            alignment: Alignment.center,
            iconEnabledColor: AppStyle.currentStyle.textColor2,
        
            onChanged: (value) {
              setState(() {
                _graphTimeSpan = value ?? GraphTimeSpan.week;
              });
            }

          ),
        ),
      ),
    );
  }

  Container _lineChart() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
      decoration: BoxDecoration(
        color: AppStyle.currentStyle.backgroundColor1,
        borderRadius: BorderRadius.circular(AppStyle.currentStyle.squareBorderRadius),
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
    switch (_graphTimeSpan) {
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
        for(WeightData? element in widget.weightPageViewModel.currentData) {
          if(element == null) continue;

          int tempDays = DateTime.now().difference(element.dateTime).inDays;
          if(tempDays > days) {
            days = tempDays;
          }
        }
        return days + 1;
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
                color: AppStyle.currentStyle.textColor2,
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
    switch (_graphTimeSpan) {
      
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

          switch (_graphTimeSpan) {
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
              AppStyle.currentStyle.highlightColor1.withOpacity(0.1),
              AppStyle.currentStyle.highlightColor2.withOpacity(0.2)
            ]
          )
        ),
        isStrokeCapRound: true,
        barWidth: barWidth,
        dotData: const FlDotData(show: false),
        color: AppStyle.currentStyle.highlightColor1,
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
    if (widget.weightPageViewModel.todaysWeightData != null) {
      spots.add(FlSpot(_days.toDouble(), widget.weightPageViewModel.todaysWeightData!.weight));
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
          color: AppStyle.currentStyle.textColor2,
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
        tooltipBgColor: AppStyle.currentStyle.backgroundColor2,
        tooltipBorder: BorderSide(
          color: AppStyle.currentStyle.backgroundColor1,
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
              color: AppStyle.currentStyle.textColor1
            ),
            children: [
              TextSpan(
                text: _allTimeFormatter.format(curData.dateTime),
                style: TextStyle(
                  color: AppStyle.currentStyle.textColor2
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
