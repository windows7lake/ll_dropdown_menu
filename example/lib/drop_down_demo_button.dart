import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

class DropDownDemoButton extends StatefulWidget {
  const DropDownDemoButton({super.key});

  @override
  State<DropDownDemoButton> createState() => _DropDownDemoButtonState();
}

class _DropDownDemoButtonState extends State<DropDownDemoButton> {
  final DropDownController dropDown1Controller = DropDownController();
  final DropDownController dropDown2Controller = DropDownController();
  final ScrollController scrollController2 = ScrollController();
  final DropDownController dropDown3Controller = DropDownController();
  final list = List.generate(10, (index) => CheckItem(text: 'Item $index'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropDown Demo Button'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              style1,
              const SizedBox(width: 40),
              style2,
              const SizedBox(width: 50),
              style3,
            ],
          ),
        ],
      ),
    );
  }

  Widget get style1 {
    return DropDownMenu(
      controller: dropDown1Controller,
      headerBoxStyle: const DropDownBoxStyle(
        height: 40,
        width: 100,
      ),
      headerItems: [
        DropDownItem(
          text: 'Select Item',
          icon: const Icon(Icons.arrow_drop_down),
          activeIcon: const Icon(Icons.arrow_drop_up),
        ),
      ],
      viewBuilders: [
        DropDownListView(
          controller: dropDown1Controller,
          boxStyle: DropDownBoxStyle(
            width: 100,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),
          items: List.generate(
            6,
            (index) => DropDownItem(
              text: "Item $index",
              data: index,
            ),
          ),
        ),
      ],
    );
  }

  Widget get style2 {
    return DropDownMenu(
      controller: dropDown2Controller,
      headerBoxStyle: DropDownBoxStyle(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      headerItemStyle: const DropDownItemStyle(
        gap: 6,
      ),
      headerItems: [
        DropDownItem(
          text: 'Select Item',
          icon: const Icon(Icons.arrow_forward_ios, size: 12),
          activeIcon: const Icon(Icons.arrow_forward_ios, size: 12),
        ),
      ],
      viewColor: Colors.transparent,
      viewBuilders: [
        DropDownViewWrapper(
          width: 100,
          height: 280,
          child: Material(
            elevation: 10,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: Scrollbar(
              controller: scrollController2,
              thumbVisibility: true,
              child: ListView.builder(
                controller: scrollController2,
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      dropDown2Controller.hide(
                        status: DropDownHeaderStatus(
                          text: 'Item $index',
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Item $index',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get style3 {
    return DropDownMenu(
      controller: dropDown3Controller,
      headerBoxStyle: const DropDownBoxStyle(
        height: 30,
        width: 30,
      ),
      headerItems: [
        DropDownItem(
          text: '',
          icon: const Icon(Icons.list),
          activeIcon: const Icon(Icons.list),
        ),
      ],
      relativeOffset: const Offset(-36, 12),
      viewColor: Colors.transparent,
      viewBuilders: [
        DropDownViewWrapper(
          width: 100,
          height: 280,
          child: Material(
            color: Colors.transparent,
            child: CustomPaint(
              size: const Size(100, 280),
              painter: TrianglePainter(dropDown3Controller),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var item = list[index];
                  return GestureDetector(
                    onTap: () {
                      item.check = !item.check;
                      dropDown3Controller.hide();
                      setState(() {});
                    },
                    child: Row(children: [
                      Checkbox(
                        value: item.check,
                        onChanged: (value) {
                          item.check = !item.check;
                          dropDown3Controller.hide();
                          setState(() {});
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      Text(item.text),
                    ]),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CheckItem {
  final String text;
  bool check;

  CheckItem({
    this.text = '',
    this.check = false,
  });
}

class TrianglePainter extends CustomPainter {
  final DropDownController controller;

  TrianglePainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    if (controller.viewHeight <= 0) return;
    Path path = Path();
    path.moveTo(size.width / 2 - 10, 0);
    path.lineTo(size.width / 2, -10);
    path.lineTo(size.width / 2 + 10, 0);
    path.lineTo(size.width - 6, 0);
    path.arcToPoint(
      Offset(size.width, 6),
      radius: const Radius.circular(6),
    );
    path.lineTo(size.width, size.height - 6);
    path.arcToPoint(
      Offset(size.width - 6, size.height),
      radius: const Radius.circular(6),
    );
    path.lineTo(6, size.height);
    path.arcToPoint(
      Offset(0, size.height - 6),
      radius: const Radius.circular(6),
    );
    path.lineTo(0, 6);
    path.arcToPoint(
      const Offset(6, 0),
      radius: const Radius.circular(6),
    );
    path.close();

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    final paintShadow = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(path, paintShadow);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
