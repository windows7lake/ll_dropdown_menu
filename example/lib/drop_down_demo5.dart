import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

import 'app_bar.dart';

class DropDownDemo5 extends StatefulWidget {
  const DropDownDemo5({super.key});

  @override
  State<DropDownDemo5> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo5>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WrapperAppBar(
        titleText: "DropDownDemo CustomScrollView",
        backgroundColor: Colors.white,
      ),
      body: Center(),
    );
  }
}
