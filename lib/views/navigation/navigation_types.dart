typedef NavigationBarButtonCallBack = void Function(int index, NavigationBarType type);

enum NavigationBarPosition {
  first,
  middle,
  last
}

enum NavigationBarType {
  weight,
  food,
  workout,
  settings
}