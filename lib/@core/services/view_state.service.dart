import 'package:flutter/widgets.dart';
import 'package:flutter_to_do/@core/enums.dart';
import 'package:flutter_to_do/@core/services/log.service.dart';

class ViewStateModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  String _errorMsg;

  ViewState get viewState => _viewState;

  String get errorMsg => _errorMsg;

  void setViewState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }

  void setErrorMsg(String errorMsg) {
    AppLogger.e(errorMsg);
    _errorMsg = errorMsg;
  }

  void showLoading() {
    setViewState(ViewState.Loading);
  }

  void startRefresh() {
    setViewState(ViewState.Refresh);
  }

  void hideLoading() {
    setViewState(ViewState.Complete);
  }

  void notifyError() {
    setViewState(ViewState.Error);
  }
}
