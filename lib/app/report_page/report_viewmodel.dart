// InheritedWidgets allow you to propagate values down the widgettree.
// it can then be accessed by just writing  TheViewModel.of(context)
import 'package:flutter/material.dart';

// InheritedWidgets allow you to propagate values down the widgettree.
// it can then be accessed by just writing  TheViewModel.of(context)
class TheViewModel extends InheritedWidget {
  final ReportPageViewModel theModel;

  const TheViewModel({Key key, @required this.theModel, @required Widget child})
      : assert(theModel != null),
        assert(child != null),
        super(key: key, child: child);

  static ReportPageViewModel of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(TheViewModel) as TheViewModel)
          .theModel;

  @override
  bool updateShouldNotify(TheViewModel oldWidget) =>
      theModel != oldWidget.theModel;
}

class ReportPageViewModel {
  ReportPageViewModel();
}
