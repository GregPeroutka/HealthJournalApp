import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/types/weight_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/views/pages/weight_page/calendar_dialog.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_dialog.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_graph.dart';


class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<StatefulWidget> createState() => _WeightPageState();

}

class _WeightPageState extends State<WeightPage> {

  final double _containerPadding = 10;
  final double _borderRadius = 20;

  final int historyCount = 7;

  List<WeightData?> historyWeightData = List.empty();
  WeightData? todaysWeightData;

  TextEditingController weightTextController = TextEditingController();

  GraphTimeSpan _curGraphTimeSpan = GraphTimeSpan.week;

  @override
  Widget build(BuildContext context) {
    historyWeightData = WeightPageViewModel.getLastNDaysWeightData(historyCount);
    todaysWeightData = WeightPageViewModel.todaysWeightData;

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
            color: ColorPalette.currentColorPalette.secondaryBackground,
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          
          child: Column(
    
            children: [
    
              _verticalPadding(8),
    
              _pageHeader(),
              _addWeightButton(),
              _todaysWeightWidget(),
    
              _graphDropDownMenu(),
              WeightGraph(timeSpan: _curGraphTimeSpan),
    
              _recentHistoryHeaderWidget(),

              _verticalPadding(8),

              _historyListWidget()
    
            ],
          )
        ),
      ),
    );
  }

  Widget _verticalPadding(double space) {
    return Padding(padding: EdgeInsets.only(top: space));
  }

  Widget _pageHeader() {
    return Center(
      child: Text(
        'Today',
        style: TextStyle(
          color: ColorPalette.currentColorPalette.hintText,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: "Rubik",
        ),
      ),
    );
  }

  Widget _addWeightButton() {
    return Visibility(
      visible: todaysWeightData != null,
      child: Stack(
        alignment: Alignment.center,
        children: [
      
          Text(
            todaysWeightData == null
              ? '---'
              : '${todaysWeightData?.weight} lbs',
            style: TextStyle(
              color: ColorPalette.currentColorPalette.text,
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontFamily: "Rubik",
            ),
          ),
      
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {

                  weightTextController.text = (todaysWeightData != null)
                    ? todaysWeightData!.weight.toString()
                    : '';

                  showDialog(
                    context: context, 
                    builder: (context) {

                      return WeightDialog(
                        onDone: () {
                          try {
                            double curWeight = double.parse(weightTextController.text);
                            if(todaysWeightData != null && todaysWeightData!.weight != curWeight) {
                              WeightPageViewModel.writeWeightData(todaysWeightData!.dateTime, curWeight).then((value) => {
                                setState(() {
                                  Navigator.of(context).pop();
                                })
                              });
                            } else {
                              Navigator.of(context).pop();
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
                icon: Icon(
                  Icons.edit,
                  size: 24,
                  color: ColorPalette.currentColorPalette.hintText
                )
              ),
            ),
          )
      
        ],
      ),
    );

  }

  Widget _todaysWeightWidget() {
    return Visibility(
      visible: todaysWeightData == null,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: ColorPalette.currentColorPalette.primary,
          borderRadius: BorderRadius.circular(1000)
        ),
        child: TextButton(
          onPressed: () => {

            weightTextController.text = '',
            showDialog(
              context: context, 
              builder: (context) {

                return WeightDialog(
                  onDone: () {
                    try {
                      double weight = double.parse(weightTextController.text);
                      WeightPageViewModel.writeTodaysWeightData(weight).then((value) => {
                        setState(() {
                          Navigator.of(context).pop();
                        })
                      });
                    } on FormatException catch (e) {
                      debugPrint(e.toString());
                    }
                    
                  },

                  textEditingController: weightTextController, 

                );

              }
            )

          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add Weight',
              style: TextStyle(
                color: ColorPalette.currentColorPalette.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ),
    );
  }

  Widget _graphDropDownMenu() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: ColorPalette.currentColorPalette.primaryBackground,
            borderRadius: BorderRadius.circular(1000)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: DropdownButton<GraphTimeSpan>(

              value: _curGraphTimeSpan,
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
                color: ColorPalette.currentColorPalette.text,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: "Rubik",
              ),
              dropdownColor: ColorPalette.currentColorPalette.secondaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              underline: const SizedBox(),
              isExpanded: false,
              alignment: Alignment.center,
              iconEnabledColor: ColorPalette.currentColorPalette.hintText,
          
              onChanged: (value) {
                setState(() {
                  _curGraphTimeSpan = value ?? GraphTimeSpan.week;
                });
              }

            ),
          ),
        ),
      ),
    );
  }

  Widget _recentHistoryHeaderWidget() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              'Last $historyCount Days',
              style: TextStyle(
                color: ColorPalette.currentColorPalette.hintText,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              decoration: BoxDecoration(
                color: ColorPalette.currentColorPalette.primaryBackground,
                shape: BoxShape.circle
              ),
              child: IconButton(
                iconSize: 30,
                color: ColorPalette.currentColorPalette.hintText,
                icon: const Icon(Icons.calendar_month),
                onPressed: _openCalendarDialog,
              ),
            ),
          )
        )
      ]
    );
  }

  void _openCalendarDialog() {
    showDialog(
      context: context, 
      builder: (context) {
        return CalendarDialog(
          onDone: () {
            setState(() {});
          },
        );
      }
    );
  }

  Widget _historyListWidget() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(_borderRadius),
          color: ColorPalette.currentColorPalette.secondaryBackground
        ),
        clipBehavior: Clip.hardEdge,
        child: ListView.builder(
          itemCount: historyCount,
      
          itemBuilder: (BuildContext context, int index) {
            return historyContainer(historyCount - index, historyWeightData[historyCount - index - 1]);
          },
        ),
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

                        WeightPageViewModel.writeWeightData(DateTime.now().subtract(Duration(days: historyCount - index + 1 )), curWeight).then((value) => {
                          setState(() {
                            Navigator.of(context).pop();
                          })
                        });
                      
                      } else {

                        if(data.weight != curWeight) {
                          WeightPageViewModel.writeWeightData(data.dateTime, curWeight).then((value) => {
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
                        index == historyCount
                          ? 'Yesterday'
                          : '${historyCount - index + 1} days ago',
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