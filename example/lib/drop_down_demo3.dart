import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

import 'app_bar.dart';

class DropDownDemo3 extends StatefulWidget {
  const DropDownDemo3({super.key});

  @override
  State<DropDownDemo3> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo3>
    with SingleTickerProviderStateMixin {
  final DropDownController dropDownController = DropDownController();
  final DropDownCascadeListDataController dataController1 =
      DropDownCascadeListDataController();
  final DropDownCascadeListDataController dataController2 =
      DropDownCascadeListDataController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  List<DropDownItem<List<DropDownItem>>> data1 = List.generate(
    6,
    (index) => DropDownItem<List<DropDownItem>>(
      text: "Tab $index",
      data: List.generate(
        index + 2,
        (index) => DropDownItem(
          text: "Tab Second $index",
          activeIcon: const Icon(Icons.check),
        ),
      ),
    ),
  );
  List<DropDownItem<List<DropDownItem>>> data2 = List.generate(
    6,
    (index) => DropDownItem<List<DropDownItem>>(
      text: "Tab $index",
      data: List.generate(
        index + 2,
        (index) => DropDownItem(
          text: "Tab Second $index",
          activeIcon: const Icon(Icons.check),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: WrapperAppBar(
        titleText: "DropDownDemo Custom",
        backgroundColor: Colors.white,
        actions: const <Widget>[
          SizedBox(),
        ],
      ),
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: double.infinity,
        color: Colors.blue,
      ),
      endDrawerEnableOpenDragGesture: false,
      body: Column(children: [
        DropDownHeader(
          controller: dropDownController,
          boxStyle: const DropDownBoxStyle(
            height: 50,
            backgroundColor: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
          itemStyle: DropDownItemStyle(
            activeIconColor: Colors.blue,
            activeTextStyle: const TextStyle(color: Colors.blue),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            activeDecoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            alignment: Alignment.center,
            highlightTextStyle: const TextStyle(color: Colors.white),
            highlightDecoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            highlightIcon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ),
          items: List.generate(
            3,
            (index) => DropDownItem<Tab>(
              text: index == 2 ? "Filter" : "Tab $index",
              icon: index == 2
                  ? const Icon(Icons.filter_alt)
                  : const Icon(Icons.arrow_drop_down),
              activeIcon: index == 2
                  ? const Icon(Icons.filter_alt)
                  : const Icon(Icons.arrow_drop_up),
            ),
          ),
          onItemTap: (index, item) {
            if (index == 2) {
              dropDownController.hide();
              scaffoldKey.currentState?.openEndDrawer();
            } else {
              dropDownController.toggle(index);
            }
          },
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                color: Colors.blue[200],
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      dataController1.resetAllItemsStatus();
                      dataController2.resetAllItemsStatus();
                      for (int i = 0; i < 2; i++) {
                        dropDownController.hide(
                          index: i,
                          status: DropDownHeaderStatus(text: "Tab$i"),
                        );
                      }
                    },
                    child: const Text("Reset"),
                  ),
                ),
              ),
              DropDownView(
                controller: dropDownController,
                builders: [
                  DropDownCascadeList(
                    controller: dropDownController,
                    dataController: dataController1,
                    headerIndex: 0,
                    secondFloorItemStyle: const DropDownItemStyle(
                      backgroundColor: Colors.white,
                      activeBackgroundColor: Color(0xFFF5F5F5),
                      activeTextStyle:
                          TextStyle(fontSize: 14, color: Colors.blue),
                      activeIconColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      textExpand: true,
                    ),
                    items: data1,
                  ),
                  DropDownCascadeList(
                    controller: dropDownController,
                    dataController: dataController2,
                    headerIndex: 1,
                    secondFloorItemStyle: const DropDownItemStyle(
                      backgroundColor: Colors.white,
                      activeBackgroundColor: Color(0xFFF5F5F5),
                      activeTextStyle:
                          TextStyle(fontSize: 14, color: Colors.blue),
                      activeIconColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      textExpand: true,
                    ),
                    items: data2,
                    maxMultiChoiceSize: 3,
                  ),
                  DropDownViewWrapper(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Container(
                      color: Colors.yellow,
                      height: 300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    dropDownController.dispose();
    super.dispose();
  }
}
