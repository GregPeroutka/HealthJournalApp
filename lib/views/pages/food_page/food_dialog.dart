import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_health_journal/app_style.dart';

class FoodDialog extends StatefulWidget{
  final Function onDone;
  final TextEditingController textEditingController;

  const FoodDialog({super.key, required this.onDone, required this.textEditingController});

  @override
  State<StatefulWidget> createState() => _FoodDialog();

}

class _FoodDialog extends State<FoodDialog> {
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,

      child: Container(
        margin: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.squareBorderRadius))
        ),
        clipBehavior: Clip.hardEdge,
        
        child: IntrinsicHeight(
          child: IntrinsicWidth(

            child: Material(
              color: AppStyle.currentStyle.backgroundColor1,
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
                          borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.completelyRoundRadius)),
                          color: AppStyle.currentStyle.backgroundColor2,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(0, 37, 37, 37),
                              blurRadius: 1.5,
                              spreadRadius: 2.5,
                            )
                          ]
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              TextField(
                              
                                controller: widget.textEditingController,
                                                                  
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppStyle.currentStyle.textColor1
                                ),
                                
                                autofocus: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                                ],
                                                      
                                decoration: InputDecoration(
                                  hintText: 'Calories',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: AppStyle.currentStyle.textColor2
                                  ),
                                ),                
                              ),
                              TextField(
                              
                                controller: widget.textEditingController,
                                                                  
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppStyle.currentStyle.textColor1
                                ),
                                
                                autofocus: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                                ],
                                                      
                                decoration: InputDecoration(
                                  hintText: 'Carbs',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: AppStyle.currentStyle.textColor2
                                  ),
                                ),                
                              ),
                              TextField(
                              
                                controller: widget.textEditingController,
                                                                  
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppStyle.currentStyle.textColor1
                                ),
                                
                                autofocus: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                                ],
                                                      
                                decoration: InputDecoration(
                                  hintText: 'Protein',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: AppStyle.currentStyle.textColor2
                                  ),
                                ),                
                              ),
                              TextField(
                              
                                controller: widget.textEditingController,
                                                                  
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppStyle.currentStyle.textColor1
                                ),
                                
                                autofocus: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                                ],
                                                      
                                decoration: InputDecoration(
                                  hintText: 'Fat',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: AppStyle.currentStyle.textColor2
                                  ),
                                ),                
                              ),
                            ],
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
                      color: AppStyle.currentStyle.highlightColor1,
                      borderRadius: BorderRadius.circular(AppStyle.currentStyle.completelyRoundRadius)
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
                            color: AppStyle.currentStyle.textColor1,
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