import 'package:flutter/material.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {

  String getStringById(String key) => getString(context, key);

  Widget baseScaffold(
      {String myTitle,
      @required Widget myBody,
      FloatingActionButton floatButton}) {
    return Scaffold(
      appBar: myTitle != null
          ? AppBar(
              backgroundColor: AppColors.mainColor,
              title: Text(getStringById(myTitle)),
            )
          : null,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) => FocusScope.of(context).unfocus(),
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(child: myBody),
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      floatingActionButton: floatButton,
    );
  }


}
