import 'package:flutter/material.dart';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/views/pages/weight_page/calendar_dialog.dart';
import 'package:my_health_journal/views/pages/weight_page/recent_weight_history_list.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_graph.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_page_header.dart';


class WeightPage extends StatefulWidget {
  final WeightPageViewModel weightPageViewModel; 
  
  const WeightPage({
    super.key,
    required this.weightPageViewModel
  });

  @override
  State<StatefulWidget> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {

  final double _containerPadding = 10;

  final int historyCount = 7;

  List<WeightData?> historyWeightData = List.empty();
  WeightData? todaysWeightData;

  TextEditingController weightTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    historyWeightData = widget.weightPageViewModel.getLastNDaysWeightData(historyCount);
    todaysWeightData = widget.weightPageViewModel.todaysWeightData;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          _containerPadding,
          0,
          _containerPadding,
          0
        ),
        
        child: Container(
          decoration: BoxDecoration(
            color: AppStyle.currentStyle.backgroundColor2,
            borderRadius: BorderRadius.circular(AppStyle.currentStyle.squareBorderRadius),
          ),
          
          child: Column(
            children: [
    
              _verticalPadding(8),

              WeightPageHeader(
                weightPageViewModel: widget.weightPageViewModel
              ),

              WeightGraph(
                weightPageViewModel: widget.weightPageViewModel, 
              ),
    
              _recentHistoryHeaderWidget(),

              _verticalPadding(8),

              Expanded(
                child: RecentWeightHistoryList(
                  weightPageViewModel: widget.weightPageViewModel, 
                  historyCount: historyCount
                ),
              )
    
            ],
          )
        ),
      ),
    );
  }

  Widget _verticalPadding(double space) {
    return Padding(padding: EdgeInsets.only(top: space));
  }

  Widget _recentHistoryHeaderWidget() {
    return Stack(
      children: [
        _recentHistoryText(),
        _calendarButton()
      ]
    );
  }

  Align _recentHistoryText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Text(
          'Last $historyCount Days',
          style: TextStyle(
            color: AppStyle.currentStyle.textColor2,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Align _calendarButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          decoration: BoxDecoration(
            color: AppStyle.currentStyle.backgroundColor1,
            shape: BoxShape.circle
          ),
          child: IconButton(
            iconSize: 30,
            color: AppStyle.currentStyle.textColor2,
            icon: const Icon(Icons.calendar_month),
            onPressed: _openCalendarDialog,
          ),
        ),
      )
    );
  }

  void _openCalendarDialog() {
    showDialog(
      context: context, 
      builder: (context) {
        return CalendarDialog(
          weightPageViewModel: widget.weightPageViewModel,
          onDone: () {
            setState(() {});
          },
        );
      }
    );
  }

}