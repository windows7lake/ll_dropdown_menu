import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

class DropDownDemo1 extends StatefulWidget {
  const DropDownDemo1({super.key});

  @override
  State<DropDownDemo1> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo1>
    with SingleTickerProviderStateMixin {
  final DropDownController dropDownController = DropDownController();
  final DropDownDisposeController dropDownDisposeController =
      DropDownDisposeController();
  List<DropDownItem> items1 = [];
  List<DropDownItem> items2 = [];
  List<DropDownItem> items3 = [];
  List<DropDownItem> items4 = [];

  @override
  void initState() {
    super.initState();
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
        activeIcon: const Icon(
          Icons.ac_unit,
          color: Colors.white,
        ),
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
          onPressed: () async {
            dropDownDisposeController
                .hideMenu()
                ?.whenComplete(() => Navigator.of(context).pop());
          },
        ),
        titleText: "DropDownDemo Overlay",
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        DropDownMenu(
          controller: dropDownController,
          disposeController: dropDownDisposeController,
          headerHeight: 50,
          headerActiveIconColor: Colors.blue,
          headerActiveTextStyle: const TextStyle(color: Colors.blue),
          headerItems: List.generate(
            4,
            (index) => DropDownItem<Tab>(
              text: "Tab $index",
              icon: const Icon(Icons.arrow_drop_down),
              activeIcon: const Icon(Icons.arrow_drop_up),
            ),
          ),
          viewOffsetY: MediaQuery.of(context).padding.top + 106,
          viewBuilders: [
            DropDownViewBuilder(
              height: 300,
              widget: DropDownListView(
                headerIndex: 0,
                controller: dropDownController,
                itemActiveBackgroundColor: Colors.blue.shade100,
                items: items1,
              ),
            ),
            DropDownViewBuilder(
              height: 300,
              widget: DropDownListView(
                controller: dropDownController,
                items: items2,
                multipleChoice: true,
                maxMultiChoiceSize: 2,
              ),
            ),
            DropDownViewBuilder(
              height: 300,
              widget: DropDownGridView(
                crossAxisCount: 3,
                controller: dropDownController,
                items: items3,
              ),
            ),
            DropDownViewBuilder(
              height: 310,
              widget: DropDownGridView(
                crossAxisCount: 3,
                controller: dropDownController,
                items: items4,
                multipleChoice: true,
                maxMultiChoiceSize: 2,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(color: Colors.blue),
        ),
      ]),
    );
  }
}
