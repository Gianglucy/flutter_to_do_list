import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/repo/todo/to_do_response.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@shared/widgets/custom_text_field/custom_editing.controller.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/resources/styles/styles.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

import 'add_item_view_model.dart';

@RoutePage(params: [RouteParameter("model")])
class AddItemScreen extends StatefulWidget {
  TodoResponse model;
  bool statusEdit = false;

  AddItemScreen({this.model}) : super();

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends BaseScreen<AddItemScreen> {
  AddItemViewModel addItemViewModel = byInject<AddItemViewModel>();
  var _controllerId = CustomEditingController();
  var _controllerName = CustomEditingController();
  var _controllerValue = CustomEditingController();

  @override
  void dispose() {
    _controllerId.dispose();
    _controllerName.dispose();
    _controllerValue.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.statusEdit = widget.model.name.isEmpty;
    addItemViewModel.modelTodo = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => addItemViewModel,
        child: Consumer<AddItemViewModel>(
          builder: (context, viewModel, child) {
            return baseScaffold(
              myTitle: widget.statusEdit
                  ? AppLangs.text_add_item
                  : AppLangs.text_edit_item,
              myBody: Container(
                child: Column(
                  children: [
                    _itemInput(
                      AppLangs.text_id,
                      _controllerId..text = viewModel.modelTodo.id.toString(),
                      enable: true,
                    ),
                    _itemInput(AppLangs.text_name,
                        _controllerName..text = viewModel.modelTodo.name,
                        onValue: (val) => viewModel.setName(val)),
                    _itemInput(
                        AppLangs.text_value,
                        _controllerValue
                          ..text = viewModel.modelTodo.value.toString(),
                        type: TextInputType.number,
                        onValue: (val) =>
                            viewModel.setValue(val.isEmpty ? "0" : val)),
                    _itemSubmit()
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _itemInput(String hint, CustomEditingController controller,
      {TextInputType type, bool enable = false, Function(String) onValue}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        readOnly: enable ?? false,
        keyboardType: type,
        maxLength: 7,
        onChanged: (value) {
          onValue(value);
        },
        decoration: InputDecoration(
          // counterText: "",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(8),
          suffixIcon: Visibility(
            visible: !enable,
            child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.grayMedium,
                ),
                onPressed: () {
                  controller.clear();
                  onValue("");
                }),
          ),
          hintText: getString(context, hint).toLowerCase(),
        ),
      ),
    );
  }

  Widget _itemSubmit() {
    return GestureDetector(
      onTap: () {
        _insertToDataBase(widget.model);
      },
      child: Container(
        width: getWidthPercen(context, 70),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.mainColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            getString(
                context,
                widget.statusEdit
                    ? AppLangs.text_add_item
                    : AppLangs.text_edit_item),
            style: AppStyles().whiteRegular(22),
          ),
        ),
      ),
    );
  }

  _insertToDataBase(TodoResponse model) async {
    var result = widget.statusEdit
        ? await addItemViewModel.addItemTodo(model)
        : await addItemViewModel.editItemTodo(model);
    if (result != -1) {
      Fluttertoast.showToast(
          msg: getString(
              context,
              widget.statusEdit
                  ? AppLangs.text_added
                  : AppLangs.text_edit_item));
      Timer(Duration(seconds: 1), () {
        popToScreen(context, result);
      });
    } else
      Fluttertoast.showToast(msg: "Input name");
  }
}
