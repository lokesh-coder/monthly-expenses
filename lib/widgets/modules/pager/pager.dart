import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:monex/widgets/modules/pager/model.dart';
import 'package:provider/provider.dart';

class Pager extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final pagerModel = Provider.of<PagerModel>(context, listen: false);

    PageController ctrl;
    ScrollPhysics physics;
    bool pageSnap;
    if (isMaster) {
      ctrl = pagerModel.createController(
        key: key,
        visibleItems: visibleItems,
        initialPage: initialPage,
        isMaster: true,
      );
      physics = AlwaysScrollableScrollPhysics();
      pageSnap = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ctrl.position.notifyListeners();
      });
    } else {
      ctrl = pagerModel.createController(
        key: key,
        visibleItems: visibleItems,
        initialPage: initialPage,
      );
      physics = NeverScrollableScrollPhysics();
      pageSnap = false;
    }

    return Selector(
      selector: (ctx, PagerModel model) => model.currentOffset,
      builder: (ctx, offset, child) {
        return PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: ctrl,
          itemCount: data.length,
          onPageChanged: (index) {
            onPageChange(data[index]);
          },
          physics: physics,
          pageSnapping: pageSnap,
          itemBuilder: (_, int index) {
            return builder(index, data[index], ctrl);
          },
        );
      },
    );
  }
}
