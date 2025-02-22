import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

import 'app_bar.dart';

class DropDownDemo2 extends StatefulWidget {
  const DropDownDemo2({super.key});

  @override
  State<DropDownDemo2> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo2>
    with SingleTickerProviderStateMixin {
  final DropDownController dropDownController = DropDownController();
  List<DropDownItem> items1 = [];
  List<DropDownItem> items2 = [];
  List<DropDownItem> items3 = [];
  List<DropDownItem> items4 = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setupData();
      setState(() {});
    });
  }

  @override
  void dispose() {
    dropDownController.dispose();
    super.dispose();
  }

  void setupData() {
    items1 = List.generate(
      6,
      (index) => DropDownItem(
        text: "Single Item $index",
        data: index,
      ),
    );
    items2 = List.generate(
      8,
      (index) => DropDownItem(
        text: "Multi Item $index",
        data: index,
      ),
    );
    items3 = List.generate(
      10,
      (index) => DropDownItem(
        text: "Single Item $index",
        icon: const Icon(Icons.ac_unit),
        activeIcon: const Icon(Icons.ac_unit),
        data: index,
      ),
    );
    items4 = List.generate(
      12,
      (index) => DropDownItem(
        text: "Multi Item $index",
        data: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WrapperAppBar(
        titleText: "DropDownDemo List & Grid",
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        DropDownHeader(
          controller: dropDownController,
          itemStyle: const DropDownItemStyle(
            activeIconColor: Colors.blue,
            activeTextStyle: TextStyle(color: Colors.blue),
          ),
          items: List.generate(
            4,
            (index) => DropDownItem<Tab>(
              text: "Tab $index",
              icon: const Icon(Icons.arrow_drop_down),
              activeIcon: const Icon(Icons.arrow_drop_up),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                color: Colors.blue[200],
              ),
              DropDownView(
                controller: dropDownController,
                builders: [
                  DropDownListView(
                    controller: dropDownController,
                    items: items1,
                  ),
                  DropDownListView(
                    controller: dropDownController,
                    items: items2,
                    maxMultiChoiceSize: 2,
                    onDropDownItemsConfirm: (List<DropDownItem> items) {
                      setState(() {});
                    },
                  ),
                  DropDownGridView(
                    controller: dropDownController,
                    crossAxisCount: 3,
                    boxStyle: const DropDownBoxStyle(
                      padding: EdgeInsets.all(16),
                    ),
                    itemStyle: DropDownItemStyle(
                      activeBackgroundColor: const Color(0xFFF5F5F5),
                      activeIconColor: Colors.blue,
                      activeTextStyle: const TextStyle(color: Colors.blue),
                      activeBorderRadius: BorderRadius.circular(6),
                    ),
                    items: items3,
                  ),
                  DropDownGridView(
                    controller: dropDownController,
                    crossAxisCount: 3,
                    boxStyle: const DropDownBoxStyle(
                      padding: EdgeInsets.all(16),
                    ),
                    itemStyle: DropDownItemStyle(
                      activeBackgroundColor: const Color(0xFFF5F5F5),
                      activeIconColor: Colors.blue,
                      activeTextStyle: const TextStyle(color: Colors.blue),
                      activeBorderRadius: BorderRadius.circular(6),
                    ),
                    items: items4,
                    maxMultiChoiceSize: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
