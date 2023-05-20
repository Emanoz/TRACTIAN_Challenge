enum AssetsStatus {
  open,
  inProgress,
  done,
  onHold,
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
    }
  }

  int color() {
    switch(this) {
      case AssetsStatus.open:
        return 0xFFE16F24 ;
      case AssetsStatus.inProgress:
        return 0xFF2188FF;
      case AssetsStatus.done:
        return 0xFF52C41A;
      case AssetsStatus.onHold:
        return 0xFFFB8F44;
    }
  }
}