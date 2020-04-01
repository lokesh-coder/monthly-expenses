import 'package:flutter/material.dart';

class Worker {
  PageController worker;
  Key key;

  Worker({this.key, this.worker});
}

class PagerModel with ChangeNotifier {
  PageController masterController;
  List<Worker> workerControllers = [];
  int masterVisibleItems = 1;
  double currentOffset = 0.0;

  PageController createController(
      {int initialPage,
      int visibleItems = 1,
      bool isMaster = false,
      dynamic key}) {
    if (isMaster) {
      if (masterController != null) {
        return masterController;
      }
      masterVisibleItems = visibleItems;
      masterController = PageController(
          initialPage: initialPage, viewportFraction: (1 / visibleItems));

      masterController.addListener(() {
        offsetChange();
      });
      return masterController;
    }
    var ctrl = PageController(
        initialPage: initialPage, viewportFraction: (1 / visibleItems));
    workerControllers.add(Worker(key: key, worker: ctrl));
    return ctrl;
  }

  offsetChange() {
    currentOffset = masterController.position.pixels * masterVisibleItems;

    workerControllers.forEach((w) {
      if (w.worker.hasClients) {
        w.worker.animateTo(
          currentOffset / (1 / w.worker.viewportFraction),
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  getController(String keyname) {
    return workerControllers.firstWhere((w) => w.key.toString() == keyname,
        orElse: () => null);
  }
}
