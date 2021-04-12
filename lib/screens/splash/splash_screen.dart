import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/@core/constants.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:flutter_to_do/screens/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

@initialPage
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseScreen<SplashScreen> {
  SplashViewModel viewModel = byInject<SplashViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<SplashViewModel>(builder: (context, viewModel, child) {
        return baseScaffold(
            myBody: SpinKitDoubleBounce(
          color: AppColors.mainColor,
          size: 50,
        ));
      }),
    );
  }

  void loadData() async {
    Timer(Duration(milliseconds: 500), () {
      goToAndRemoveScreen(context, AppConstants.ROUTE_HOME_SCREEN);
    });
  }
}
