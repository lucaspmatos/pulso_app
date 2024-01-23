import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:pulso_app/app/router/routes.dart';
import 'package:pulso_app/app/components/components.dart';
import 'package:pulso_app/app/core/constants/constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kIsWeb
          ? Numbers.drawerWebSize
          : MediaQuery.of(context).size.width * Numbers.drawerAppWidth,
      child: Drawer(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Header(),
                const Divider(color: ColorConstants.grey),
                DrawerItem(
                  icon: Icons.monitor_heart,
                  text: Texts.monitor,
                  onTap: () => Routes.monitorRoute(context),
                ),
                const Divider(color: ColorConstants.grey),
                DrawerItem(
                  icon: Icons.history,
                  text: Texts.history,
                  onTap: () => Routes.historyRoute(context),
                ),
                const Divider(color: ColorConstants.grey),
                DrawerItem(
                  icon: Icons.contacts,
                  text: Texts.contacts,
                  onTap: () => Routes.contactsRoute(context),
                ),
                const Divider(color: ColorConstants.grey),
                const Spacer(),
                Divider(color: Colors.pinkAccent.shade200),
                DrawerItem(
                  icon: Icons.logout_rounded,
                  iconColor: Colors.pinkAccent.shade200,
                  text: Texts.logout,
                  textColor: Colors.pinkAccent.shade200,
                  onTap: kIsWeb
                      ? () => Routes.splashScreenRoute(context)
                      : () => Routes.loginRoute(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
