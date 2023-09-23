import 'package:flutter/material.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget{
  final Function onDone;
  final WeightPageViewModel weightPageViewModel;
  
  const CalendarDialog({
    super.key,
    required this.weightPageViewModel,
    required this.onDone
  });

  @override
  State<StatefulWidget> createState() => _CalendarDialog();
}

class _CalendarDialog extends State<CalendarDialog> {
  final double _borderRadius = 20;

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  WeightData? _selectedWeightData;

  final TextStyle _titleTextStyle = TextStyle(color: ColorPalette.currentColorPalette.text);
  final TextStyle _weekdayTextStyle = TextStyle(color: ColorPalette.currentColorPalette.hintText);
  final TextStyle _selectableDayTextStyle = TextStyle(fontSize: 18, color: ColorPalette.currentColorPalette.text);
  final TextStyle _unselectableDayTextStyle = TextStyle(fontSize: 12, color: ColorPalette.currentColorPalette.disabledText);

  final TextEditingController _editWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _selectedWeightData = widget.weightPageViewModel.getWeightData(_selectedDay);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorPalette.currentColorPalette.primaryBackground,
                  borderRadius: BorderRadius.circular(_borderRadius)
                ),
        
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now(),
        
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: _titleTextStyle,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: ColorPalette.currentColorPalette.primary),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: ColorPalette.currentColorPalette.primary)
                    ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: _weekdayTextStyle,
                    weekendStyle: _weekdayTextStyle
                  ),
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: false,
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                      color: ColorPalette.currentColorPalette.primary,
                      shape: BoxShape.circle
                    ),
                    defaultTextStyle: _selectableDayTextStyle,
                    weekendTextStyle: _selectableDayTextStyle,
                    disabledTextStyle: _unselectableDayTextStyle,
                  ),
        
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedWeightData = widget.weightPageViewModel.getWeightData(selectedDay);
                    });
                  },
        
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, focusedDay) {
                      if(widget.weightPageViewModel.getWeightData(day) != null) {
                        return Icon(
                          Icons.circle,
                          color: ColorPalette.currentColorPalette.hintText,
                          size: 10,
                        );
                      }
                      return null;
                    },
                  ),
        
                )
              ),
        
              Container(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: ColorPalette.currentColorPalette.primaryBackground,
                  borderRadius: BorderRadius.circular(1000)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        _selectedWeightData != null
                          ? '${_selectedWeightData!.weight.toString()} lbs'
                          : '---',
                        style: TextStyle(
                          color: ColorPalette.currentColorPalette.text,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: ((context) {
                                _editWeightController.text = (_selectedWeightData != null) 
                                  ? _selectedWeightData!.weight.toString()
                                  : '';
                                return WeightDialog(
                                  onDone: () {
                                    setState(() {
                                      if(_selectedWeightData != null) {
                                        widget.weightPageViewModel.writeWeightData(_selectedWeightData!.dateTime, double.parse(_editWeightController.text));
                                      } else {
                                        widget.weightPageViewModel.writeWeightData(_selectedDay, double.parse(_editWeightController.text));
                                      }
                                      _selectedWeightData = widget.weightPageViewModel.getWeightData(_selectedDay);
                                    });
                                    widget.onDone();
                                    Navigator.of(context).pop();
                                  }, 
                                  textEditingController: _editWeightController 
                                );
                              })
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: ColorPalette.currentColorPalette.hintText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}