import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:monex/helpers/pager_helper.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';

final pagerHelper = PagerHelper();

class Pager extends StatefulWidget {
  final Widget Function(int index, dynamic data, PageController ctrl) builder;
  final List data;
  final bool isMaster;
  final int visibleItems;
  final int initialPage;
  final Function onPageChange;
  Pager(
      {Key key,
      this.builder,
      this.data,
      this.visibleItems,
      this.initialPage,
      this.onPageChange})
      : isMaster = false,
        super(key: key);

  Pager.master(
      {Key key,
      this.builder,
      this.data,
      this.visibleItems,
      this.initialPage,
      this.onPageChange})
      : isMaster = true,
        super(key: key);

  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  PageController ctrl;
  ScrollPhysics physics;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data.length != oldWidget.data.length)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        var currMonth = sl<SettingsStore>().monthsViewRange;
        if (currMonth.toDouble() != ctrl.page && widget.isMaster) {
          ctrl.jumpToPage(currMonth);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    bool pageSnap;
    if (widget.isMaster) {
      ctrl = pagerHelper.createController(
        key: widget.key,
        visibleItems: widget.visibleItems,
        initialPage: widget.initialPage,
        isMaster: true,
      );
      physics = AlwaysScrollableScrollPhysics();
      pageSnap = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ctrl.position.notifyListeners();
      });
    } else {
      ctrl = pagerHelper.createController(
        key: widget.key,
        visibleItems: widget.visibleItems,
        initialPage: widget.initialPage,
      );
      physics = NeverScrollableScrollPhysics();
      pageSnap = false;
    }

    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: ctrl,
      itemCount: widget.data.length,
      onPageChanged: (index) {
        widget.onPageChange(widget.data[index]);
      },
      physics: physics,
      pageSnapping: pageSnap,
      itemBuilder: (_, int index) {
        return widget.builder(index, widget.data[index], ctrl);
      },
    );
  }
}
