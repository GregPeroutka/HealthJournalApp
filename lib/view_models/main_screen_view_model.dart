import 'dart:async';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';

class MainScreenViewModel {

  static final StreamController<PageType> _pageStreamController = StreamController<PageType>();
  static final Stream<PageType> _pageBroadcastStream = _pageStreamController.stream.asBroadcastStream();
  static final StreamSink<PageType> _pageStreamSink = _pageStreamController.sink;

  static Stream<PageType> get pageBroadcastStream => _pageBroadcastStream;
  static StreamSink<PageType> get pageStreamSink => _pageStreamSink;

  static void loadWeight() {
    _pageStreamSink.add(PageType.loading);

    WeightPageViewModel.loadData().then((value) => {
      _pageStreamSink.add(PageType.weight)
    });
  }

}