import 'dart:async';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_dialog.dart';

class WeightPageHeader extends StatefulWidget {

  final WeightPageViewModel weightPageViewModel;
  
  const WeightPageHeader({
    super.key,
    required this.weightPageViewModel
  });

  @override
  State<WeightPageHeader> createState() => _WeightPageHeaderState();
}

class _WeightPageHeaderState extends State<WeightPageHeader> {
  final TextEditingController _weightTextController = TextEditingController();
  late final StreamSubscription _onDataUpdatedSubscription;

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
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        _header(),
        _mainBody()
      ],
    );
  }

  Center _header() {
    return Center(
      child: Text(
        'Today',
        style: TextStyle(
          color: AppStyle.currentStyle.textColor2,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: "Rubik",
        ),
      ),
    );
  }

  Widget _mainBody() {
    if(widget.weightPageViewModel.todaysWeightData == null) {
      return _addTodaysWeightHeader();
    } else {
      return _displayAndEditTodaysWeightHeader();
    }
  }

  Widget _addTodaysWeightHeader() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppStyle.currentStyle.highlightColor1,
        borderRadius: BorderRadius.circular(AppStyle.currentStyle.completelyRoundRadius)
      ),
      child: TextButton(
        onPressed: () => {

          _weightTextController.text = '',
          _addWeightShowDialog()

        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Add Weight',
            style: TextStyle(
              color: AppStyle.currentStyle.textColor1,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }

  Future<dynamic> _addWeightShowDialog() {
    return showDialog(
      context: context, 
      builder: (context) {

        return WeightDialog(
          onDone: () {
            try {
              double weight = double.parse(_weightTextController.text);
              widget.weightPageViewModel.writeTodaysWeightData(weight).then((value) => Navigator.of(context).pop());
            } on FormatException catch (e) {
              debugPrint(e.toString());
            }
          },
          textEditingController: _weightTextController, 
        ); 
      }
    );
  }

  Widget _displayAndEditTodaysWeightHeader() {
    double todaysWeight = (widget.weightPageViewModel.todaysWeightData) != null
      ? widget.weightPageViewModel.todaysWeightData!.weight
      : -1;

    return Stack(
      alignment: Alignment.center,
      children: [
        _currentWeightText(todaysWeight),
        _editCurrentWeightButton(todaysWeight)
      ],
    );
  }

  Align _editCurrentWeightButton(double todaysWeight) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () {

            _weightTextController.text = todaysWeight.toString();

            _editWeightShowDialog(todaysWeight);
          },
          icon: Icon(
            Icons.edit,
            size: 24,
            color: AppStyle.currentStyle.textColor2
          )
        ),
      ),
    );
  }

  Text _currentWeightText(double todaysWeight) {
    return Text(
      '$todaysWeight lbs',
      style: TextStyle(
        color: AppStyle.currentStyle.textColor1,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: "Rubik",
      ),
    );
  }

  Future<dynamic> _editWeightShowDialog(double todaysWeight) {
    return showDialog(
      context: context, 
      builder: (context) {

        return WeightDialog(
          onDone: () {
            try {
              double inputWeight = double.parse(_weightTextController.text);
              if(todaysWeight != inputWeight) {
                widget.weightPageViewModel.writeTodaysWeightData(inputWeight).then((value) => Navigator.of(context).pop());
              } else {
                Navigator.of(context).pop();
              }
              
            } on FormatException catch (e) {
              debugPrint(e.toString());
            }
          },
          textEditingController: _weightTextController, 
        );
      }
    );
  }
}