import 'package:flutter/material.dart';

class BottomModalControl {
  Function(String title, Widget child) open;
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
            isDismissible: false,
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => _layout(ctx, title, child),
          );
        };

        data.close = () => Navigator.of(context).pop();
        return builder(context, data);
      },
    );
  }

  _content(ctx, title, child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(title)),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
        child
      ],
    );
  }

  _layout(ctx, title, child) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: _content(ctx, title, child),
      ),
    );
  }
}
