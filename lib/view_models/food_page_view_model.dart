import 'dart:async';

import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/view_models/page_view_model.dart';

class FoodPageViewModel extends PageViewModel {

  @override
  PageType pageType = PageType.food;

  Future loadData() async {
    return Future.value(true);
  }
}