import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_health_journal/color_palette.dart';

class WeightDialog extends StatefulWidget{
  final Function onDone;
  final TextEditingController textEditingController;

  const WeightDialog({super.key, required this.onDone, required this.textEditingController});

  @override
  State<StatefulWidget> createState() => _WeightDialog();

}

class _WeightDialog extends State<WeightDialog> {

  final double _borderRadius = 20;
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,

      child: Container(
        margin: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))
        ),
        clipBehavior: Clip.hardEdge,
        
        child: IntrinsicHeight(
          child: IntrinsicWidth(

            child: Material(
              color: ColorPalette.currentColorPalette.primaryBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  Expanded(
                    child: Center(
                      child: Container(
          
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        width: 240,
          
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(1000)),
                          color: ColorPalette.currentColorPalette.secondaryBackground,
                          boxShadow: [
                            ColorPalette.currentColorPalette.primaryShadow
                          ]
                        ),
          
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextField(

                            controller: widget.textEditingController,
                                                              
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorPalette.currentColorPalette.text
                            ),
                            
                            autofocus: true,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                            ],
                        
                            decoration: InputDecoration(
                              hintText: 'Weight',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: ColorPalette.currentColorPalette.hintText
                              ),
                            ),
                                                    
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 20)),
          
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 50,
                      minWidth: 100
                    ),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: ColorPalette.currentColorPalette.primary,
                      borderRadius: BorderRadius.circular(1000)
                    ),
                    child: TextButton(
                      onPressed: () {
                        widget.onDone();
                      }, 
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: ColorPalette.currentColorPalette.text,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
          
                  const Padding(padding: EdgeInsets.only(top: 20))
                ],
              ),
            ),

          ),
        ),

      ),
    );
  }

}