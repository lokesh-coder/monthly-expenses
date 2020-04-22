import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/layout_helper.dart';
import "package:monex/config/extension.dart";

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
      builder: (context) {
        var data = BottomModalControl();
        data.open = (title, child) {
          FocusScope.of(context).requestFocus(new FocusNode());

          showModalBottomSheet(
            isDismissible: true,
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(LayoutHelper.mainPageKey.currentContext)
                      .viewInsets
                      .bottom,
                ),
                child: SingleChildScrollView(
                    child: _layout(ctx, title, child, data)),
              );
            },
          );
        };

        data.close = () => Navigator.of(context).pop();
        return builder(context, data);
      },
    );
  }

  _content(ctx, String title, child, data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: data.showHeader,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title.capitalize(),
                  style: TextStyle(
                    color: Clrs.dark,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        child
      ],
    );
  }

  _layout(ctx, title, child, data) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: _content(ctx, title, child, data),
      ),
    );
  }
}
