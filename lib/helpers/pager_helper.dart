import 'package:flutter/material.dart';

class Worker {
  PageController worker;
  Key key;

  Worker({this.key, this.worker});
}

class PagerHelper {
  PageController masterController;
  List<Worker> workerControllers = [];
  int masterVisibleItems = 1;
  double currentOffset = 0.0;

  PageController createController(
      {int initialPage, int visibleItems = 1, bool isMaster = false, Key key}) {
    if (isMaster) {
      if (masterController != null) {
        return masterController;
      }
      masterVisibleItems = visibleItems;
      return masterController = PageController(
          initialPage: initialPage, viewportFraction: 1 / visibleItems)
        ..addListener(offsetChange);
    }
    final ctrl = PageController(
        initialPage: initialPage, viewportFraction: 1 / visibleItems);
    workerControllers.add(Worker(key: key, worker: ctrl));
    return ctrl;
  }

  void offsetChange() {
    workerControllers.forEach((w) {
      if (w.worker.hasClients) {
        currentOffset = masterController.position.pixels * masterVisibleItems;
        w.worker.jumpTo(currentOffset / (1 / w.worker.viewportFraction));
      }
    });
  }

  Worker getController(String keyname) {
    return workerControllers.firstWhere((w) => w.key.toString() == keyname,
        orElse: () => null);
  }
}
