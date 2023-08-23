typedef NavigationBarButtonCallBack = void Function(int index, NavigationBarButtonType type);
typedef NavigationBarCallBack = void Function(NavigationBarButtonType type);

enum NavigationBarButtonType {
  weight,
  food,
  workout,
  settings
}

enum PageType {
  loading,
  weight,
  food,
  workout,
  settings
}

enum NavigationBarPosition {
  first,
  middle,
  last
}