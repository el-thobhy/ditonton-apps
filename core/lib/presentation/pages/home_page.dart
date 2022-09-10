import 'package:core/common/drawer_item_enum.dart';
import 'package:flutter/foundation.dart';

class HomeDrawerNotifier extends ChangeNotifier {
  DrawerItem _selectedDrawerItem = DrawerItem.movie;
  DrawerItem get selectedDrawerItem => _selectedDrawerItem;

  void setSelectedDrawerItem(DrawerItem newItem) {
    _selectedDrawerItem = newItem;
    notifyListeners();
  }
}
