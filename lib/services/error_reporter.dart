import "package:catcher/catcher_plugin.dart";
import "package:flutter/material.dart";
import "package:monex/config/app.dart";

var dialogMode = DialogReportMode();
var consoleMode = ConsoleHandler();
var emailHandler = EmailManualHandler([AppConfig.errReportEmail]);

var debugOptions = CatcherOptions(dialogMode, [ConsoleHandler()]);
var releaseOptions = CatcherOptions(dialogMode, [emailHandler]);

handleErrors(Widget rootWidget) {
  Catcher(rootWidget, debugConfig: debugOptions, releaseConfig: releaseOptions);
}
