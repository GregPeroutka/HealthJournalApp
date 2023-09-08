import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    historyWeightData = WeightPageViewModel.getLastNDaysWeightData(historyCount);
    todaysWeightData = WeightPageViewModel.getTodaysWeightData();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          _containerPadding,
          _containerPadding,
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

              _verticalPadding(8),

              _graphWidget(),
    
              _verticalPadding(8),
    
              _recentHistoryHeaderWidget(),
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
                              WeightPageViewModel.overwriteWeightData(todaysWeightData!, curWeight).then((value) => {
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

  Widget _graphWidget() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ColorPalette.currentColorPalette.primaryBackground,
        borderRadius: BorderRadius.circular(_borderRadius),
      )
    );
  }

  Widget _recentHistoryHeaderWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, bottom: 8),
        child: Text(
          'Last $historyCount Days',
          style: TextStyle(
            color: ColorPalette.currentColorPalette.hintText,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _historyListWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: historyCount,

        itemBuilder: (BuildContext context, int index) {
          return historyContainer(index, historyWeightData[index]);
        },
      ),
    );
  }

  Widget historyContainer(int index, WeightData? data) {

    return Container(
      margin: const EdgeInsets.all(8.0),
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

                        // Writes WeightData for today minus 'index + 1' amount of days
                        WeightPageViewModel.writeWeightData(Timestamp.fromDate(Timestamp.now().toDate().subtract(Duration(days: index + 1))), curWeight).then((value) => {
                          setState(() {
                            Navigator.of(context).pop();
                          })
                        });
                        
                      } else {

                        if(data.weight != curWeight) {
                          WeightPageViewModel.overwriteWeightData(data, curWeight).then((value) => {
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
                        index == 0
                          ? 'Yesterday'
                          : '${index + 1} days ago',
                        style: TextStyle(
                          color: ColorPalette.currentColorPalette.hintText,
                          fontSize: 18,
                        ),
                      ),
                
                      Text(
                        data == null
                          ? '---'
                          : DateFormat('MMMM d').format(data.timestamp.toDate()),
                        style: TextStyle(
                          color: ColorPalette.currentColorPalette.hintText,
                          fontSize: 14,
                        ),
                      ),
                        
                    ],
                  ),
                ),
          
                const Spacer(),
                
                const Text('TEst')
              ],
            ),
          ),
        ),
      )
    );
  }

}