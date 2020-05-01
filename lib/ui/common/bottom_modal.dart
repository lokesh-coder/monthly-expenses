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
  final bool hasPadding;

  const BottomModal({this.builder, this.hasPadding = true});

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
            bgColor: Clrs.dark.withOpacity(0.4),
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
            onClickOut: (pop) => pop.dismiss(context),
            childFun: (pop) {
              return Container(
                key: GlobalKey(),
                width: LayoutHelper.screenWidth,
                color: Colors.transparent,
                child: _ModalLayout(
                  pop: pop,
                  child: child,
                  dataCtx: data,
                  title: title,
                  hasPadding: hasPadding,
                ),
              );
            },
          );
        };

        data.close = () => trigger.dismiss(context);
        return builder(context, data);
      },
    );
  }
}

class _ModalLayout extends StatelessWidget {
  final KumiPopupWindow pop;
  final String title;
  final Widget child;
  final BottomModalControl dataCtx;
  final bool hasPadding;

  const _ModalLayout(
      {this.pop, this.title, this.child, this.dataCtx, this.hasPadding});

  @override
  Widget build(BuildContext context) {
    var screenH = LayoutHelper.screenHeight;
    var container = Container(
      padding: EdgeInsets.all(hasPadding ? 20 : 0),
      color: Colors.white,
      child: _ModalContent(
        pop: pop,
        child: child,
        dataCtx: dataCtx,
        title: title,
      ),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: screenH * Dimensions.bottomSheetMinHeight,
        maxHeight: screenH * Dimensions.bottomSheetMaxHeight,
      ),
      child: container,
    );
  }
}

class _ModalContent extends StatelessWidget {
  final KumiPopupWindow pop;
  final String title;
  final Widget child;
  final BottomModalControl dataCtx;

  const _ModalContent({this.pop, this.title, this.child, this.dataCtx});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: dataCtx.showHeader,
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
                        MIcons.close_rd,
                        color: Clrs.dark.withOpacity(0.3),
                      ),
                      onPressed: () => pop.dismiss(context),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(visible: dataCtx.showHeader, child: SizedBox(height: 10)),
        child
      ],
    );
  }
}
