// class Firebaseoptions {}
import 'package:code_jam_app/resources/basic_exports.dart';

class HomeViewModel with ChangeNotifier {
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  String? _searchValue;
  String? get searchValue => _searchValue;

  void setValue(String value) {
    _searchValue = value;
    notifyListeners();
  }
}
