import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_dialog.dart';

class RecentWeightHistoryList extends StatefulWidget {
  final WeightPageViewModel weightPageViewModel;
  final int historyCount;

  const RecentWeightHistoryList({
    super.key,
    required this.weightPageViewModel,
    required this.historyCount
  });

  @override
  State<RecentWeightHistoryList> createState() => _RecentWeightHistoryListState();
}

class _RecentWeightHistoryListState extends State<RecentWeightHistoryList> {
  late final StreamSubscription _onDataUpdatedSubscription;
  TextEditingController weightTextController = TextEditingController();

  final double _borderRadius = 20;

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
    List<WeightData?> historyWeightData = widget.weightPageViewModel.getLastNDaysWeightData(widget.historyCount);

    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(_borderRadius),
        color: ColorPalette.currentColorPalette.secondaryBackground
      ),
      clipBehavior: Clip.hardEdge,
      child: ListView.builder(
        itemCount: widget.historyCount,
    
        itemBuilder: (BuildContext context, int index) {
          return historyContainer(widget.historyCount - index, historyWeightData[widget.historyCount - index - 1]);
        },
      ),
    );
  }

  Widget historyContainer(int index, WeightData? data) {

    return Container(
      margin: const EdgeInsets.only(top: 16),
      clipBehavior: Clip.hardEdge,

      decoration: BoxDecoration(
        color: ColorPalette.currentColorPalette.primaryBackground,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),

      child: Material(
        color: Colors.transparent,
        child: InkWell(
          
          onTap: () {
            weightTextController.text = (data != null)
              ? data.weight.toString()
              : '';

            showDialog(
              context: context, 
              builder: (context) {

                return WeightDialog(
                  onDone: () {
                    try {
                      double curWeight = double.parse(weightTextController.text);
                      if(data == null) {

                        widget.weightPageViewModel.writeWeightData(DateTime.now().subtract(Duration(days: widget.historyCount - index + 1 )), curWeight).then((value) => {
                          setState(() {
                            Navigator.of(context).pop();
                          })
                        });
                      
                      } else {

                        if(data.weight != curWeight) {
                          widget.weightPageViewModel.writeWeightData(data.dateTime, curWeight).then((value) => {
                            setState(() {
                              Navigator.of(context).pop();
                            }
                          )});
                        } else {
                          Navigator.of(context).pop();
                        }

                      }
                    } on FormatException catch (e) {
                      debugPrint(e.toString());
                    }
                  },

                  textEditingController: weightTextController, 
                );

              }
            );
          },

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
          
                const Padding(padding: EdgeInsets.only(left: 8.0)),
          
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                
                      Text(
                        data == null
                          ? '---'
                          : '${data.weight.toString()} lbs',
                        style: TextStyle(
                          color: ColorPalette.currentColorPalette.text,
                          fontSize: 24,
                        ),
                      ),
                        
                      Text(
                        index == widget.historyCount
                          ? 'Yesterday'
                          : '${widget.historyCount - index + 1} days ago',
                        style: TextStyle(
                          color: ColorPalette.currentColorPalette.hintText,
                          fontSize: 18,
                        ),
                      ),
                
                      Text(
                        data == null
                          ? '---'
                          : DateFormat('EEEE, MMMM d').format(data.dateTime),
                        style: TextStyle(
                          color: ColorPalette.currentColorPalette.hintText,
                          fontSize: 14,
                        ),
                      ),
                        
                    ],
                  ),
                ),
          
                const Spacer(),
                
                Text('$index')
              ],
            ),
          ),
        ),
      )
    );
  }
}