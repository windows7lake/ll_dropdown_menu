import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

class DropDownDemo4 extends StatefulWidget {
  const DropDownDemo4({super.key});

  @override
  State<DropDownDemo4> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo4>
    with SingleTickerProviderStateMixin {
  final GlobalKey dropDownMenuKey = GlobalKey();
  final dropDownMenuHeight = 50.0;

  DropDownController dropDownController = DropDownController();
  DropDownDisposeController dropDownDisposeController =
      DropDownDisposeController();
  List<DropDownItem> items1 = [];
  List<DropDownItem> items2 = [];
  List<DropDownItem> items3 = [];
  List<DropDownItem> items4 = [];

  bool isUsingOverlay = false;

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

  double get dropDownViewOffsetY {
    RenderBox? renderBox = dropDownMenuKey.renderObject as RenderBox?;
    if (renderBox == null) return 0;
    double dy = renderBox.localToGlobal(Offset.zero).dy;
    return dy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WrapperAppBar(
        leading: BackButton(
          onPressed: () async {
            if (isUsingOverlay) {
              dropDownDisposeController
                  .hideMenu()
                  ?.whenComplete(() => Navigator.of(context).pop());
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        titleText: "DropDownDemo CustomScrollView",
        backgroundColor: Colors.white,
        actions: [
          WrapperButton(
            onPressed: () {
              dropDownController = DropDownController();
              dropDownDisposeController = DropDownDisposeController();
              isUsingOverlay = !isUsingOverlay;
              setState(() {});
            },
            text: "Switch",
          ),
        ],
      ),
      body: isUsingOverlay ? usingOverlay() : usingStack(),
    );
  }

  Widget usingOverlay() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text(
              "Using Overlay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverPersistentHeaderBuilder(
            height: dropDownMenuHeight,
            builder: (context, offset) {
              return DropDownMenu(
                key: dropDownMenuKey,
                controller: dropDownController,
                disposeController: dropDownDisposeController,
                headerBoxStyle: DropDownBoxStyle(
                  height: dropDownMenuHeight,
                  backgroundColor: Colors.white,
                ),
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
                onHeaderItemTap: (index, item) {
                  dropDownController.toggle(
                    index,
                    offsetY: dropDownViewOffsetY,
                  );
                },
                viewOffsetY: MediaQuery.of(context).padding.top + // statusBar
                    55 + // appBar
                    100 + // blue Container
                    dropDownMenuHeight,
                viewBuilders: [
                  DropDownViewBuilder(
                    height: 300,
                    widget: DropDownListView(
                      controller: dropDownController,
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
                      maxMultiChoiceSize: 2,
                    ),
                  ),
                  DropDownViewBuilder(
                    height: 262,
                    widget: DropDownGridView(
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
                    height: 300,
                    widget: DropDownGridView(
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
                      controller: dropDownController,
                      items: List.generate(
                        12,
                            (index) => DropDownItem(
                          text: "Multi Item $index",
                          data: index,
                        ),
                      ),
                      maxMultiChoiceSize: 2,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              color:
                  index % 2 == 0 ? Colors.grey.shade300 : Colors.grey.shade200,
            );
          },
          itemCount: 20,
        ),
      ],
    );
  }

  Widget usingStack() {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text(
                  "Using Stack",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverPersistentHeaderBuilder(
                height: dropDownMenuHeight,
                builder: (context, offset) {
                  return DropDownHeader(
                    key: dropDownMenuKey,
                    controller: dropDownController,
                    boxStyle: DropDownBoxStyle(
                      height: dropDownMenuHeight,
                      backgroundColor: Colors.white,
                    ),
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
                    onItemTap: (index, item) {
                      dropDownController.toggle(
                        index,
                        offsetY: dropDownViewOffsetY +
                            dropDownMenuHeight -
                            statusBarHeight -
                            56, // appBar
                      );
                    },
                  );
                },
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  color: index % 2 == 0
                      ? Colors.grey.shade300
                      : Colors.grey.shade200,
                );
              },
              itemCount: 20,
            ),
          ],
        ),
        DropDownView(
          controller: dropDownController,
          builders: [
            DropDownViewBuilder(
              height: 300,
              widget: DropDownListView(
                headerIndex: 0,
                controller: dropDownController,
                items: items1,
              ),
            ),
            DropDownViewBuilder(
              height: 300,
              widget: DropDownListView(
                controller: dropDownController,
                items: items2,
                maxMultiChoiceSize: 2,
              ),
            ),
            DropDownViewBuilder(
              height: 262,
              widget: DropDownGridView(
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
                controller: dropDownController,
                items: items3,
              ),
            ),
            DropDownViewBuilder(
              height: 300,
              widget: DropDownGridView(
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
                controller: dropDownController,
                items: items4,
                maxMultiChoiceSize: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
