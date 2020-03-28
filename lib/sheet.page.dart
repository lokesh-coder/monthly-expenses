import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class Sheet extends StatefulWidget {
  const Sheet({Key key}) : super(key: key);

  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  PageController nameController;
  PageController amountController;
  bool _fromamount = false;
  bool _fromname = false;
  double lastval;
  double top;
  int activepage;

  @override
  void initState() {
    super.initState();
    top = 0.0;
    nameController = new PageController(
      // initialPage: 3,
      viewportFraction: 0.5,
    );
    amountController = new PageController();
  }

  _getSlip() {
    return [
      ['january', '4500'],
      ['febraury', '2100'],
      ['march', '9800'],
      ['april', '1230'],
      ['may', '7322'],
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width * 0.5);
    return Scaffold(
        appBar: AppBar(
          title: Text('Monex'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white10,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          top = 0;
                        });
                      },
                      child: Text('close'))
                ],
              ),
            ),
            TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: top),
                duration: Duration(milliseconds: 200),
                builder: (context, double val, child) {
                  print('val ${val.runtimeType}');
                  return Transform.translate(
                    offset: Offset(0, val),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: PageView.builder(
                              controller: amountController,
                              itemCount: 5,
                              physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (int) async {
                                lastval = amountController.offset * 0.5;
                                _fromamount = true;
                                if (!_fromname) {
                                  await nameController.animateTo(
                                    amountController.offset * 0.5,
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 100),
                                  );
                                }
                                _fromamount = false;
                              },
                              itemBuilder: (ctx, int) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  color: Colors.red.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        _getSlip()[int][1],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              top = -400.0;
                                            });
                                          },
                                          child: Text('move top'))
                                    ],
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 4,
                                blurRadius: 5.0,
                                color: Colors.black12,
                                offset: Offset(0, 6),
                              )
                            ],
                          ),
                          child: PageView.builder(
                            controller: nameController,
                            itemCount: 5,
                            onPageChanged: (pageno) async {
                              print('fromamiunt $_fromamount');

                              _fromname = true;
                              if (!_fromamount) {
                                await amountController.animateTo(
                                  nameController.offset * 2,
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 100),
                                );
                              }
                              _fromname = false;
                              setState(() {
                                activepage = pageno;
                              });
                            },
                            itemBuilder: (ctx, int) {
                              print('--->>> $activepage $int');
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                // color: RandomColor().randomColor(
                                //     colorBrightness: ColorBrightness.dark),
                                child: AnimatedDefaultTextStyle(
                                  duration: Duration(milliseconds: 200),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: activepage == int ? 20 : 15,
                                  ),
                                  child: Text(
                                    _getSlip()[int][0],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ));
  }
}
