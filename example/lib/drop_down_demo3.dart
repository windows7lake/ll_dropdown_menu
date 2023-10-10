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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WrapperAppBar(
        titleText: "DropDownDemo Custom",
        backgroundColor: Colors.white,
      ),
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
                  DropDownViewBuilder(
                    height: 300,
                    widget: DropDownCascadeList(
                      controller: dropDownController,
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
                      onDropDownItemsConfirm: (items) {
                        print(items);
                      },
                    ),
                  ),
                  DropDownViewBuilder(
                    height: 300,
                    widget: DropDownCascadeList(
                      controller: dropDownController,
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
                      maxMultiChoiceSize: 1,
                      onDropDownItemsConfirm: (items) {
                        print(items);
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
