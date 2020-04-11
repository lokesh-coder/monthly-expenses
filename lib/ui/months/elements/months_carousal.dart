import 'package:flutter/material.dart';

class MonthsCarousal extends StatefulWidget {
  final int index;
  final dynamic data;
  final PageController ctrl;
  final double scaleDistance = 2;

  const MonthsCarousal(this.index, this.data, this.ctrl, {Key key})
      : super(key: key);

  @override
  _MonthsCarousalState createState() => _MonthsCarousalState();
}

class _MonthsCarousalState extends State<MonthsCarousal> {
  double fs = -1;

  _scrollListener() {
    var px = (widget.index - widget.ctrl.page);
    if (px >= -widget.scaleDistance && px <= widget.scaleDistance) {
      setState(() {
        fs = 1 - px.abs();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.ctrl.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Transform.scale(
          scale: 1 + (0.4 * fs),
          child: AnimatedOpacity(
            opacity: (0.35 * (fs + 2)).clamp(0.0, 1.0),
            duration: Duration(milliseconds: 400),
            child: Text(
              widget.data['monthName'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xff757193)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.ctrl.removeListener(_scrollListener);
    super.dispose();
  }
}