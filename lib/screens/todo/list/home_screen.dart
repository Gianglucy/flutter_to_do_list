import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/constants.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@core/repo/todo/to_do_response.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

import '../../base_screen.dart';
import 'home_view_model.dart';

@page
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen> {
  HomeViewModel viewModel = byInject<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getListTodo();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
        return baseScaffold(
            myTitle: AppLangs.text_title_home,
            myBody: viewModel.listTodo.isNotEmpty
                ? _itemListTodo(viewModel.listTodo)
                : _itemNoValue(),
            floatButton: _floatButton());
      }),
    );
  }

  Widget _itemNoValue() {
    return Container(
      child: Center(
        child: Text(
          getString(context, AppLangs.text_no_data),
          style: AppStyles().grayBold(20),
        ),
      ),
    );
  }

  Widget _itemListTodo(List<TodoResponse> list) {
    return SingleChildScrollView(
      child: Container(
        width: getWidthPercen(context, 100),
        child: DataTable(
          columns: [
            _itemColumn(AppLangs.text_id),
            _itemColumn(AppLangs.text_name),
            _itemColumn(AppLangs.text_value),
            _itemColumn(AppLangs.text_deleted),
          ],
          rows: _getListRow(list),
          showCheckboxColumn: false,
          headingTextStyle: AppStyles().grayBold(13),
          columnSpacing: 40,
        ),
      ),
    );
  }

  _itemColumn(String title) => DataColumn(
      label: Text(
          title.isNotEmpty ? getString(context, title).toUpperCase() : ""));

  _getListRow(List<TodoResponse> list) => list
      .map((e) => DataRow(onSelectChanged: (val) => _showDialog(e), cells: [
            DataCell(
              Text("${e.id}"),
              showEditIcon: true,
              onTap: () => _gotoAndGetAction(e),
            ),
            DataCell(Text(e.name)),
            DataCell(Text("${e.value}")),
            DataCell(
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.mainColor,
                ),
                onPressed: () {
                  _deleteTodo(e);
                },
              ),
            )
          ]))
      .toList();

  Widget _floatButton() {
    int id = viewModel.listTodo.length != 0
        ? viewModel.listTodo[viewModel.listTodo.length - 1].id + 1
        : 1;
    return FloatingActionButton(
      child: Icon(
        Icons.add_circle,
        color: AppColors.white,
        size: 50,
      ),
      onPressed: () => _gotoAndGetAction(TodoResponse(id: id)),
      // onPressed: () => viewModel.addTodo(),
    );
  }

  _gotoAndGetAction(TodoResponse item) async {
    var result =
        await goToScreen(context, AppConstants.ROUTE_ADD_ITEM_SCREEN, item);
    if (result != 0) viewModel.getListTodo();
  }

  _deleteTodo(TodoResponse item) async {
    var result = await viewModel.deleteTodo(item);
    if (result != 0)
      Fluttertoast.showToast(msg: getString(context, AppLangs.text_deleted));
  }

  _showDialog(TodoResponse item) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
              title: Text(getString(context, AppLangs.text_detail_todo)),
              content: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("${item.id} - ${item.name} - ${item.value}"),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  child: Text(getString(context, AppLangs.text_delete_item)),
                  onPressed: () {
                    _deleteTodo(item);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
