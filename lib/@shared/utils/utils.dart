import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/localization/app_translations.dart';

String getString(BuildContext context, String key) =>
    AppTranslations.of(context).text(key);

double getWidthPercen(BuildContext context, int percen) =>
    (MediaQuery.of(context).size.width * percen) / 100;

double getHeightPercen(BuildContext context, int percen) =>
    (MediaQuery.of(context).size.height * percen) / 100;

void popToScreen(BuildContext context, [dynamic params]) =>
    Navigator.pop(context, params);

Future goToScreen(BuildContext context, String screen,
        [dynamic params]) async =>
    await Navigator.of(context).pushNamed(screen, arguments: params);

Future goToAndRemoveScreen(BuildContext context, String screen,
    [dynamic params]) async {
  return await Navigator.of(context).pushNamedAndRemoveUntil(
      screen, (Route<dynamic> route) => false,
      arguments: params);
}
