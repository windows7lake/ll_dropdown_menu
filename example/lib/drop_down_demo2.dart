import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

class DropDownDemo2 extends StatefulWidget {
  const DropDownDemo2({super.key});

  @override
  State<DropDownDemo2> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo2>
    with SingleTickerProviderStateMixin {
  final DropDownController dropDownController = DropDownController();

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
          height: 50,
          activeIconColor: Colors.blue,
          activeTextStyle: const TextStyle(color: Colors.blue),
          items: List.generate(
            4,
            (index) => Tab(
              text: "Tab $index",
              icon: const Icon(Icons.arrow_drop_down),
            ),
          )
              .map((e) => DropDownItem<Tab>(
                    text: e.text,
                    icon: e.icon,
                    activeIcon: const Icon(Icons.arrow_drop_up),
                    data: e,
                  ))
              .toList(),
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
                    widget: DropDownListView(
                      headerIndex: 0,
                      controller: dropDownController,
                      itemActiveBackgroundColor: Colors.blue.shade100,
                      items: List.generate(
                        6,
                        (index) => DropDownItem(
                          text: "Single Item $index",
                          data: index,
                        ),
                      ),
                    ),
                  ),
                  DropDownViewBuilder(
                    height: 300,
                    widget: DropDownListView(
                      controller: dropDownController,
                      items: List.generate(
                        8,
                        (index) => DropDownItem(
                          text: "Multi Item $index",
                          data: index,
                        ),
                      ),
                      multipleChoice: true,
                      maxMultiChoiceSize: 2,
                    ),
                  ),
                  DropDownViewBuilder(
                    height: 300,
                    widget: DropDownGridView(
                      crossAxisCount: 3,
                      controller: dropDownController,
                      items: List.generate(
                        10,
                        (index) => DropDownItem(
                          text: "Single Item $index",
                          icon: const Icon(Icons.ac_unit),
                          activeIcon: const Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                          data: index,
                        ),
                      ),
                    ),
                  ),
                  DropDownViewBuilder(
                    height: 310,
                    widget: DropDownGridView(
                      crossAxisCount: 3,
                      controller: dropDownController,
                      items: List.generate(
                        12,
                        (index) => DropDownItem(
                          text: "Multi Item $index",
                          data: index,
                        ),
                      ),
                      multipleChoice: true,
                      maxMultiChoiceSize: 2,
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
