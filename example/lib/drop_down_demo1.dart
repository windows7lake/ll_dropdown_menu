import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

import 'app_bar.dart';

class DropDownDemo1 extends StatefulWidget {
  const DropDownDemo1({super.key});

  @override
  State<DropDownDemo1> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo1>
    with SingleTickerProviderStateMixin {
  final DropDownController dropDownController = DropDownController();
  final DropDownListDataController dropDownListDataController1 =
      DropDownListDataController();
  final DropDownListDataController dropDownListDataController2 =
      DropDownListDataController();
  final DropDownGridDataController dropDownGridDataController =
      DropDownGridDataController();
  final DropDownDisposeController dropDownDisposeController =
      DropDownDisposeController();
  List<DropDownItem> items1 = [];
  List<DropDownItem> items2 = [];
  List<DropDownItem> items3 = [];
  List<DropDownItem> items4 = [];

  bool _landscape = false;

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
        leading: BackButton(
          onPressed: dropDownDisposeController.hideMenuThenPop,
        ),
        titleText: "DropDownDemo Overlay",
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        DropDownMenu(
          controller: dropDownController,
          disposeController: dropDownDisposeController,
          headerItemStyle: const DropDownItemStyle(
            activeIconColor: Colors.blue,
            activeTextStyle: TextStyle(color: Colors.blue),
          ),
          headerItems: List.generate(
            4,
            (index) => DropDownItem<Tab>(
              text: "Tab $index",
              icon: const Icon(Icons.arrow_drop_down),
              activeIcon: const Icon(Icons.arrow_drop_up),
            ),
          ),
          viewOffsetY: MediaQuery.of(context).padding.top + 56,
          viewBuilders: [
            DropDownListView(
              controller: dropDownController,
              dataController: dropDownListDataController1,
              items: items1,
              headerIndex: 0,
              onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
                return DropDownHeaderStatus(
                  text: checkedItems.map((e) => e.text).toList().join("、"),
                  highlight: checkedItems.isNotEmpty,
                );
              },
            ),
            DropDownListView(
              controller: dropDownController,
              dataController: dropDownListDataController2,
              items: items2,
              maxMultiChoiceSize: 2,
              headerIndex: 1,
              onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
                return DropDownHeaderStatus(
                  text: checkedItems.map((e) => e.text).toList().join("、"),
                  highlight: checkedItems.isNotEmpty,
                );
              },
            ),
            DropDownGridView(
              controller: dropDownController,
              dataController: dropDownGridDataController,
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
              headerIndex: 2,
              onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
                return DropDownHeaderStatus(
                  text: checkedItems.map((e) => e.text).toList().join("、"),
                  highlight: checkedItems.isNotEmpty,
                );
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
              items: items4,
              maxMultiChoiceSize: 2,
              headerIndex: 3,
              onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
                return DropDownHeaderStatus(
                  text: checkedItems.map((e) => e.text).toList().join("、"),
                  highlight: checkedItems.isNotEmpty,
                );
              },
            ),
          ],
          maskFullScreen: true,
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    dropDownListDataController1.resetAllItemsStatus();
                    dropDownListDataController2.resetAllItemsStatus();
                    dropDownGridDataController.resetAllItemsStatus();
                    for (int i = 0; i < 3; i++) {
                      dropDownController.hide(
                        index: i,
                        status: DropDownHeaderStatus(text: "Tab$i"),
                      );
                    }
                  },
                  child: const Text("Reset"),
                ),
                TextButton(
                  onPressed: () {
                    _landscape = !_landscape;
                    if (_landscape) {
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.immersive);
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    } else {
                      SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.manual,
                        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
                      );
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                    }
                  },
                  child: const Text("TextButton"),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
