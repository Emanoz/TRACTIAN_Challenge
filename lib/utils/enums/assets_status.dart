enum AssetsStatus {
  open,
  inProgress,
  done,
  completed,
  onHold,
  high,
  inAlert,
  inOperation,
  inDowntime,
  plannedStop,
}

extension AssetsStatusExteension on AssetsStatus {
  String text() {
    switch(this) {
      case AssetsStatus.open:
        return 'Open';
      case AssetsStatus.inProgress:
        return 'In Progress';
      case AssetsStatus.done:
        return 'Done';
      case AssetsStatus.onHold:
        return 'On Hold';
      case AssetsStatus.completed:
        return 'Completed';
      case AssetsStatus.high:
        return 'High';
      case AssetsStatus.inAlert:
        return 'In Alert';
      case AssetsStatus.inOperation:
        return 'In Operation';
      case AssetsStatus.inDowntime:
        return 'In Downtime';
      case AssetsStatus.plannedStop:
        return 'Planned Stop';
    }
  }

  int color() {
    switch(this) {
      case AssetsStatus.open:
        return 0xFFE16F24 ;
      case AssetsStatus.inProgress:
        return 0xFF2188FF;
      case AssetsStatus.completed:
      case AssetsStatus.done:
        return 0xFF52C41A;
      case AssetsStatus.plannedStop:
      case AssetsStatus.inDowntime:
      case AssetsStatus.inOperation:
      case AssetsStatus.inAlert:
      case AssetsStatus.onHold:
        return 0xFFFB8F44;
      case AssetsStatus.high:
        return 0xFFFA4549;
    }
  }
}