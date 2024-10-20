import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenName;
  final Color backgroundColor;
  final Color statusBarColor;
  final bool showBackButton;

  const CommonAppBar({
    Key? key,
    this.screenName = "",
    this.backgroundColor = const Color.fromARGB(255, 23, 235, 168),
    this.statusBarColor = const Color.fromARGB(255, 23, 235, 168),
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(screenName),
      backgroundColor: backgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: statusBarColor),
      automaticallyImplyLeading: showBackButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
