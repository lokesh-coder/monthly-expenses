import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:monthlyexp/config/app.dart';

DialogReportMode dialogMode = DialogReportMode();
ConsoleHandler consoleMode = ConsoleHandler();
EmailManualHandler emailHandler =
    EmailManualHandler([AppConfig.errReportEmail]);

CatcherOptions debugOptions = CatcherOptions(dialogMode, [ConsoleHandler()]);
CatcherOptions releaseOptions = CatcherOptions(dialogMode, [emailHandler]);

Widget handleErrors(Widget rootWidget) {
  Catcher(rootWidget, debugConfig: debugOptions, releaseConfig: releaseOptions);
  return rootWidget;
}
