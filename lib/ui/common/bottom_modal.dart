import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/dimensions.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/helpers/layout_helper.dart';
import "package:monex/config/extension.dart";
import 'package:monex/ui/common/hint.dart';

class BottomModalControl {
  Function(String title, Widget child) open;
  bool showHeader = true;
  Function() close;
  BottomModalControl();
}

class BottomModal extends StatelessWidget {
  final Function(BuildContext, BottomModalControl) builder;

  const BottomModal({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) {
        var data = BottomModalControl();
        var trigger;
        data.open = (title, child) {
          return showPopupWindow(
            context,
            gravity: KumiPopupGravity.centerBottom,
            bgColor: Clrs.primary.withOpacity(0.3),
            clickOutDismiss: false,
            clickBackDismiss: true,
            customAnimation: false,
            customPop: false,
            customPage: false,
            underStatusBar: false,
            underAppBar: true,
            offsetX: 0,
            offsetY: 0,
            duration: Duration(milliseconds: 200),
            onShowStart: (pop) {
              trigger = pop;
            },
            onDismissStart: (pop) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            onClickOut: (pop) {
              pop.dismiss(context);
            },
            childFun: (pop) {
              return Container(
                key: GlobalKey(),
                width: LayoutHelper.screenWidth,
                color: Colors.transparent,
                child: _layout(pop, title, child, data),
              );
            },
          );
        };

        data.close = () => trigger.dismiss(context);
        return builder(context, data);
      },
    );
  }

  _content(KumiPopupWindow pop, String title, child, data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: data.showHeader,
          child: Container(
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    title.capitalize(),
                    textAlign: TextAlign.center,
                    style: Style.heading.md,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Hint(
                    Labels.closeModal,
                    child: IconButton(
                      icon: Icon(
                        MIcons.close_line,
                        color: Clrs.dark.withOpacity(0.3),
                      ),
                      onPressed: () =>
                          pop.dismiss(LayoutHelper.mainPageKey.currentContext),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        child
      ],
    );
  }

  _layout(KumiPopupWindow pop, title, child, data) {
    var screenH = LayoutHelper.screenHeight;
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: screenH * Dimensions.bottomSheetMinHeight,
        maxHeight: screenH * Dimensions.bottomSheetMaxHeight,
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: _content(pop, title, child, data),
        ),
      ),
    );
  }
}
