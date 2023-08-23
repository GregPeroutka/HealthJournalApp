import 'dart:async';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';

class MainScreenViewModel {

  static StreamController<PageType> pageStreamController = StreamController<PageType>();

  static void loadWeight() {
    pageStreamController.sink.add(PageType.loading);

    WeightPageViewModel.loadData().then((value) => {
      pageStreamController.sink.add(PageType.weight)
    });
  }

}