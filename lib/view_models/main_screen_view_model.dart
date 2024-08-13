import 'dart:async';
import 'package:my_health_journal/view_models/food_page_view_model.dart';
import 'package:my_health_journal/view_models/loading_page_view_model.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/view_models/page_view_model.dart';

class MainScreenViewModel {

  final StreamController<PageViewModel> _pageStreamController = StreamController<PageViewModel>();
  late final Stream<PageViewModel> _pageBroadcastStream = _pageStreamController.stream.asBroadcastStream();
  late final StreamSink<PageViewModel> _pageStreamSink = _pageStreamController.sink;

  Stream<PageViewModel> get pageBroadcastStream => _pageBroadcastStream;
  StreamSink<PageViewModel> get pageStreamSink => _pageStreamSink;

  final LoadingPageViewModel _loadingPageViewModel = LoadingPageViewModel();
  final WeightPageViewModel _weightPageViewModel = WeightPageViewModel();
  final FoodPageViewModel _foodPageViewModel = FoodPageViewModel();

  void loadWeight() {
    _pageStreamSink.add(_loadingPageViewModel);

    _weightPageViewModel.loadData().then((value) => {
      _pageStreamSink.add(_weightPageViewModel)
    });
  }

  void loadFood() {
    _pageStreamSink.add(_loadingPageViewModel);

    _foodPageViewModel.loadData().then((value) => {
      _pageStreamSink.add(_foodPageViewModel)
    });
  }

}