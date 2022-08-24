import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawer_State();
}

class _NavDrawer_State extends State<NavDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer();
  }
}
