import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

class DropDownDemoTaobao extends StatefulWidget {
  const DropDownDemoTaobao({super.key});

  @override
  State<DropDownDemoTaobao> createState() => _DropDownDemoTaobaoState();
}

class _DropDownDemoTaobaoState extends State<DropDownDemoTaobao>
    with TickerProviderStateMixin {
  final List<String> tabs = ["全部", "地猫", "店铺", "商品"];
  final List<String> subTabs = ["推荐", "关注", "热门"];
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  late TabController _subTabController;
  final DropDownController _dropDown1Controller = DropDownController();
  final DropDownDisposeController _dropDown1DisposeController =
      DropDownDisposeController();
  final DropDownController _dropDown2Controller = DropDownController();
  final DropDownDisposeController _dropDown2DisposeController =
      DropDownDisposeController();
  List<DropDownItem> items1 = [];
  List<DropDownItem> items2 = [];
  double offsetY = 0;
  double cardHeight = 250;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      offsetY = _scrollController.offset;
      setState(() {});
    });
    _tabController = TabController(length: tabs.length, vsync: this);
    _subTabController = TabController(length: subTabs.length, vsync: this);
    items1 = List.generate(
      6,
      (index) => DropDownItem(
        text: "Single Item $index",
        data: index,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _dropDown1Controller.dispose();
    super.dispose();
  }

  double get statusBarHeight => MediaQuery.of(context).padding.top;

  double get topHeight => kToolbarHeight + statusBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: offsetY / (cardHeight + 26) < 1
            ? Colors.transparent
            : Colors.orange.shade100,
        title: const Text("Taobao"),
      ),
      body: Stack(children: [
        TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            if (e == "全部") {
              return Stack(children: [
                Container(
                  height: topHeight + cardHeight + 100,
                  width: double.infinity,
                  color: Colors.yellow,
                ),
                nestedScrollView,
              ]);
            }
            return Center(child: Text(e));
          }).toList(),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: topHeight - (offsetY - cardHeight - 26).clamp(0, topHeight),
          ),
          child: SizedBox(
            height: 50,
            child: TabBar(
              dividerHeight: 0,
              dividerColor: Colors.transparent,
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ),
      ]),
    );
  }

  Widget get nestedScrollView {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(child: headerCard),
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: SliverPersistentHeaderBuilder(
              height: offsetY > (cardHeight + 76) ? topHeight + 50 : 50,
              builder: (context, innerBoxIsScrolled) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    child: dropDownMenu1,
                  ),
                );
              },
            ),
          ),
        ];
      },
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 20,
        itemBuilder: (context, index) {
          if (index == 0) {
            return SizedBox(height: 50, child: dropDownMenu2);
          }
          return Container(
            height: 50,
            color: index % 2 == 0 ? Colors.grey.shade300 : Colors.grey.shade200,
            child: Center(child: Text("Item $index")),
          );
        },
      ),
    );
  }

  Widget get headerCard {
    return Stack(children: [
      Container(
        height: cardHeight,
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          top: (offsetY > (cardHeight + 76) ? 0 : topHeight) + 50 + 10,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                height: 30,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 30,
                child: TabBar(
                  controller: _subTabController,
                  dividerHeight: 0,
                  dividerColor: Colors.transparent,
                  tabs: subTabs.map((e) => Tab(text: e)).toList(),
                  indicatorColor: Colors.orange,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  onTap: (index) {
                    cardHeight = (index == 1 ? 400 : 250);
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              const SizedBox(height: 20),
              Container(
                height: 20,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              if (cardHeight > 250)
                Container(
                  height: 120,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
            ],
          ),
        ),
      ),
      Positioned.fill(
        child: IgnorePointer(
          child: Container(
            color: Color.lerp(
              Colors.transparent,
              Colors.orange.shade100,
              (offsetY / (cardHeight + 26)).clamp(0, 1),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget get dropDownMenu1 {
    return DropDownMenu(
      controller: _dropDown1Controller,
      disposeController: _dropDown1DisposeController,
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
      viewBuilders: [
        DropDownListView(
          controller: _dropDown1Controller,
          items: items1,
        ),
        DropDownListView(
          controller: _dropDown1Controller,
          items: items1,
        ),
        DropDownListView(
          controller: _dropDown1Controller,
          items: items1,
        ),
        DropDownListView(
          controller: _dropDown1Controller,
          items: items1,
        ),
      ],
      maskFullScreen: true,
    );
  }

  Widget get dropDownMenu2 {
    return DropDownMenu(
      controller: _dropDown2Controller,
      disposeController: _dropDown2DisposeController,
      headerPhysics: const BouncingScrollPhysics(),
      headerBoxStyle: const DropDownBoxStyle(
        height: 50,
        width: 100,
        backgroundColor: Colors.white,
        expand: false,
      ),
      headerItemStyle: DropDownItemStyle(
        iconColor: const Color(0xFF666666),
        activeIconColor: const Color(0xFF666666),
        textStyle: const TextStyle(color: Color(0xFF666666)),
        activeTextStyle: const TextStyle(color: Color(0xFF666666)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        activePainter: BorderPainter(),
      ),
      headerItems: List.generate(
        8,
        (index) => DropDownItem<Tab>(
          text: "Sub $index",
          icon: const Icon(Icons.arrow_drop_down),
          activeIcon: const Icon(Icons.arrow_drop_up),
        ),
      ),
      viewColor: Colors.white,
      viewBuilders: List.generate(8, (index) {
        return DropDownListView(
          controller: _dropDown2Controller,
          items: items1,
          itemStyle: DropDownItemStyle(
            backgroundColor: Colors.grey.shade200,
            activeBackgroundColor: Colors.grey.shade200,
          ),
        );
      }),
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(16, 8);
    path.lineTo(size.width - 26, 8);
    path.arcToPoint(
      Offset(size.width - 8, size.height / 2),
      radius: const Radius.circular(20),
    );
    path.lineTo(size.width - 8, size.height - 8);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: const Radius.circular(10),
      clockwise: false,
    );
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(8, size.height - 8),
      radius: const Radius.circular(10),
      clockwise: false,
    );
    path.lineTo(8, size.height / 2);
    path.arcToPoint(const Offset(26, 8), radius: const Radius.circular(20));
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
