import 'package:flutter/material.dart';

import 'package:pulso_app/app/core/themes/themes.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

class DrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DrawerAppBar({
    Key? key,
    this.context,
    required this.title,
    this.bottom,
    this.actions,
    this.iconColor = ColorConstants.strongGrey,
    this.size = kToolbarHeight,
  }) : super(key: key);

  final double size;
  final BuildContext? context;
  final String title;
  final PreferredSizeWidget? bottom;
  final Color? iconColor;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.white,
      centerTitle: true,
      title: Text(
        title,
        style: getTextTheme(context).displaySmall?.copyWith(
              fontSize: Numbers.drawerAppBarFontSize,
            ),
      ),
      titleSpacing: Numbers.zero,
      iconTheme: IconThemeData(color: iconColor),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size);
}
