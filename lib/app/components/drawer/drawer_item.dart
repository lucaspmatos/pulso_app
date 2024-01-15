import 'package:flutter/material.dart';

import 'package:pulso_app/app/core/themes/themes.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

class DrawerItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconColor ?? ColorConstants.strongGrey,
          ),
          Padding(
            padding: Numbers.defaultLeftPadding,
            child: Text(
              text,
              style: getTextTheme(context)
                  .headlineMedium
                  ?.copyWith(color: textColor),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
