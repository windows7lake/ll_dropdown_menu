import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

class DropDownDemo3 extends StatefulWidget {
  const DropDownDemo3({super.key});

  @override
  State<DropDownDemo3> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo3>
    with SingleTickerProviderStateMixin {
  final DropDownController dropDownController = DropDownController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.white,
          activeIconColor: Colors.blue,
          activeTextStyle: const TextStyle(color: Colors.blue),
          itemDecoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          activeItemDecoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          itemMargin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          itemAlignment: Alignment.center,
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
              ),
              DropDownView(
                controller: dropDownController,
                builders: [
                  DropDownViewBuilder(
                    height: 300,
                    widget: DropDownCascadeList(
                      controller: dropDownController,
                      headerIndex: 0,
                      items: List.generate(
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
                      ),
                      onDropDownHeaderUpdate:
                          (List<DropDownItem> checkedItems) {
                        return checkedItems
                            .map((e) => e.text)
                            .toList()
                            .join("、");
                      },
                    ),
                  ),
                  DropDownViewBuilder(
                    height: 300,
                    widget: DropDownCascadeList(
                      controller: dropDownController,
                      headerIndex: 1,
                      items: List.generate(
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
                      ),
                      multipleChoice: true,
                      maxMultiChoiceSize: 3,
                      onDropDownHeaderUpdate:
                          (List<DropDownItem> checkedItems) {
                        return checkedItems
                            .map((e) => e.text)
                            .toList()
                            .join("、");
                      },
                    ),
                  ),
                  DropDownViewBuilder(
                    height: 300,
                    widget: Container(
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
}
