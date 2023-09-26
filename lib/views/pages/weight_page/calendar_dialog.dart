import 'package:flutter/material.dart';
import 'package:my_health_journal/app_style.dart';
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
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  WeightData? _selectedWeightData;

  final TextStyle _titleTextStyle = TextStyle(color: AppStyle.currentStyle.textColor1);
  final TextStyle _weekdayTextStyle = TextStyle(color: AppStyle.currentStyle.textColor2);
  final TextStyle _selectableDayTextStyle = TextStyle(fontSize: 18, color: AppStyle.currentStyle.textColor1);
  final TextStyle _unselectableDayTextStyle = TextStyle(fontSize: 12, color: AppStyle.currentStyle.textColor3);

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
                  color: AppStyle.currentStyle.backgroundColor1,
                  borderRadius: BorderRadius.circular(AppStyle.currentStyle.squareBorderRadius)
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
                      color: AppStyle.currentStyle.highlightColor1),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: AppStyle.currentStyle.highlightColor1)
                    ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: _weekdayTextStyle,
                    weekendStyle: _weekdayTextStyle
                  ),
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: false,
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                      color: AppStyle.currentStyle.highlightColor1,
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
                      debugPrint(selectedDay.day.toString());
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
                          color: AppStyle.currentStyle.textColor2,
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
                  color: AppStyle.currentStyle.backgroundColor1,
                  borderRadius: BorderRadius.circular(AppStyle.currentStyle.completelyRoundRadius)
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
                          color: AppStyle.currentStyle.textColor1,
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
                                      widget.weightPageViewModel.writeWeightData(_selectedDay, double.parse(_editWeightController.text));
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
                            color: AppStyle.currentStyle.textColor2,
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