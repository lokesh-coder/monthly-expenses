import 'package:flutter/material.dart';

class BottomSheetData {
  Function(String title, Widget child) open;
  BottomSheetData();
}

class PickableBottomSheet extends StatelessWidget {
  final Function builder;

  const PickableBottomSheet({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var data = BottomSheetData();
      data.open = (title, contentChild) {
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(child: Text(title)),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    contentChild
                  ],
                ),
              ),
            );
          },
        );
      };
      return builder(context, data);
    });
  }
}
