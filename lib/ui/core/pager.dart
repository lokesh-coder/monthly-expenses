import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:monthlyexp/helpers/pager_helper.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';

final PagerHelper pagerHelper = PagerHelper();

class Pager extends StatefulWidget {
  final Widget Function(int index, Map data, PageController ctrl) builder;
  final List data;
  final bool isMaster;
  final int visibleItems;
  final int initialPage;
  final Function onPageChange;
  Pager(
      {this.builder,
      this.data,
      this.visibleItems,
      this.initialPage,
      this.onPageChange})
      : isMaster = false;

  Pager.master(
      {this.builder,
      this.data,
      this.visibleItems,
      this.initialPage,
      this.onPageChange})
      : isMaster = true;

  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  PageController ctrl;
  ScrollPhysics physics;

  @override
  void didUpdateWidget(Pager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data.length != oldWidget.data.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currMonth = sl<SettingsStore>().monthsViewRange;
        if (currMonth.toDouble() != ctrl.page && widget.isMaster) {
          ctrl.jumpToPage(currMonth);
        }
      });
    }
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
