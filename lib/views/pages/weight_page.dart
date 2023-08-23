import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/models/database_model.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';

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

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: WeightPageViewModel.getLastNDaysWeightData(historyCount),
      initialData: List<WeightData?>.filled(historyCount, null),

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        historyWeightData = snapshot.data ?? List<WeightData?>.filled(historyCount, null);

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
        
                  const Padding(padding: EdgeInsets.only(top: 8)),
        
                  Center(
                    child: Text(
                      'Today',
                      style: TextStyle(
                        color: ColorPalette.currentColorPalette.hintText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Rubik",
                      ),
                    ),
                  ),
        
                  Center(
                    child: Text(
                      '181.4 lbs',
                      style: TextStyle(
                        color: ColorPalette.currentColorPalette.text,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Rubik",
                      ),
                    ),
                  ),
        
                  Container(
                    height: 200,
                    margin: const EdgeInsets.all(8.0),
                        
                    decoration: BoxDecoration(
                      color: ColorPalette.currentColorPalette.primaryBackground,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    )
        
                  ),
        
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorPalette.currentColorPalette.primaryBackground,
                            shape: BoxShape.circle
                          ),
                          child: IconButton(
                            onPressed: () {
        
                              DatabaseModel.writeWeightData(
                                WeightData(
                                  note: '',
                                  weight: 182.0,
                                  timestamp: Timestamp.fromDate(DateTime.now().subtract(Duration(days: 5)))
                                )
                              );
                              
                            },
                            icon: Icon(
                              Icons.add_rounded,
                              color: ColorPalette.currentColorPalette.text,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
        
                  const Padding(padding: EdgeInsets.only(top: 8)),
        
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, bottom: 8),
                      child: Text(
                        'Last $historyCount Days',
                        style: TextStyle(
                          color: ColorPalette.currentColorPalette.hintText,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Rubik",
                        ),
                      ),
                    ),
                  ),
        
                  Expanded(
                    child: ListView.builder(
                      itemCount: historyCount,
        
                      itemBuilder: (BuildContext context, int index) {
                        return historyContainer(index, historyWeightData[index]);
                      },
                    ),
                  ),
      
                ],
              )
            ),
          ),
        );
      }
      
    );
  }

  Container historyContainer(int index, WeightData? data) {

    return Container(
      margin: const EdgeInsets.all(8.0),

      decoration: BoxDecoration(
        color: ColorPalette.currentColorPalette.primaryBackground,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Expanded(
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
                        fontFamily: "Rubik",
                      ),
                    ),
                      
                    Text(
                      index == 0
                        ? 'Yesterday'
                        : '${index + 1} days ago',
                      style: TextStyle(
                        color: ColorPalette.currentColorPalette.hintText,
                        fontSize: 18,
                        fontFamily: "Rubik",
                      ),
                    ),
              
                    Text(
                      data == null
                        ? '---'
                        : DateFormat('MMMM d').format(data.timestamp.toDate()),
                      style: TextStyle(
                        color: ColorPalette.currentColorPalette.hintText,
                        fontSize: 14,
                        fontFamily: "Rubik",
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
      )
    );
  }

}