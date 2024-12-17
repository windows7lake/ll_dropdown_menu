import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

import 'app_bar.dart';

class DropDownDemo5 extends StatefulWidget {
  const DropDownDemo5({super.key});

  @override
  State<DropDownDemo5> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo5>
    with SingleTickerProviderStateMixin {
  final DropDownController dropDownController = DropDownController();
  final DropDownListDataController dropDownListDataController1 =
      DropDownListDataController();
  final DropDownListDataController dropDownListDataController2 =
      DropDownListDataController();
  final DropDownDisposeController dropDownDisposeController =
      DropDownDisposeController();
  List<DropDownItem> items1 = [];
  List<DropDownItem> items2 = [];

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
    dropDownDisposeController.dispose();
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
            3,
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
            CustomDropDownView(
              onConfirm: (String text) {
                dropDownController.hide(
                  index: 2,
                  status: DropDownHeaderStatus(text: text),
                );
              },
            ),
          ],
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

  Widget get customDropDownView {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              dropDownController.hide();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}

class CustomDropDownView extends DropDownViewStatefulWidget {
  final Function(String text)? onConfirm;

  const CustomDropDownView({super.key, this.onConfirm});

  @override
  State<CustomDropDownView> createState() => _CustomDropDownViewState();

  @override
  double get actualHeight => 700;
}

class _CustomDropDownViewState extends State<CustomDropDownView> {
  int listSelected = -1;
  int wrapSelected = -1;
  int gridSelected = -1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    listSelected = index;
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    color: Colors.primaries[index % Colors.primaries.length]
                        .withOpacity(0.2),
                    alignment: Alignment.center,
                    child: Text(
                      "List $index",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            listSelected == index ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Text("标题", style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Wrap(
                children: List.generate(
                  10,
                  (index) => GestureDetector(
                    onTap: () {
                      wrapSelected = index;
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: index * 5 + 70,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Wrap $index",
                        style: TextStyle(
                          fontSize: 20,
                          color: wrapSelected == index
                              ? Colors.blue
                              : Colors.black,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text("标题", style: TextStyle(fontSize: 20)),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    gridSelected = index;
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Grid $index",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            gridSelected == index ? Colors.blue : Colors.black,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () {
                    widget.onConfirm?.call(
                        "List $listSelected + Wrap $wrapSelected + Grid $gridSelected");
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
