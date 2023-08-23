import 'dart:async';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';

class MainScreenViewModel {

  static StreamController<PageType> pageStreamController = StreamController<PageType>();

  MainScreenViewModel() {

  }

  static void loadWeightViewModel() {
    pageStreamController.sink.add(PageType.loading);

    WeightPageViewModel.LoadData().then((value) => {
      pageStreamController.sink.add(PageType.weight)
    });
  }

}