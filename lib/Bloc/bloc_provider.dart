import 'package:flutter/material.dart';
import 'package:just_like_this/Bloc/likeBloc.dart';

class BlocProvider extends InheritedWidget {
  final LikeBloc likeBloc;

  final Widget child;

  BlocProvider({this.likeBloc, this.child}) : super(child: child);

  static BlocProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(BlocProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
