import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/views/pages/weight_page/add_weight_dialog.dart';

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

  TextEditingController addWeightTextController = TextEditingController();

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
    
              Visibility(
                visible: todaysWeightData != null,
                child: Center(
                  child: Text(
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
                ),
              ),

              const Padding(padding: EdgeInsets.only(top: 8)),

              Visibility(
                visible: todaysWeightData == null,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: ColorPalette.currentColorPalette.primary,
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: TextButton(
                    onPressed: () => {

                      showDialog(
                        context: context, 
                        builder: (context) {

                          return AddWeightDialog(
                            onDone: () => {
                              debugPrint('test :D'),
                              Navigator.of(context).pop()
                            },
                            textEditingController: addWeightTextController, 
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
              ),

              Container(
                height: 200,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: ColorPalette.currentColorPalette.primaryBackground,
                  borderRadius: BorderRadius.circular(_borderRadius),
                )
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

  Container historyContainer(int index, WeightData? data) {

    return Container(
      margin: const EdgeInsets.all(8.0),

      decoration: BoxDecoration(
        color: ColorPalette.currentColorPalette.primaryBackground,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
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
      )
    );
  }

}