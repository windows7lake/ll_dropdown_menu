import 'package:flutter/material.dart';

import 'drop_down_demo1.dart';
import 'drop_down_demo2.dart';
import 'drop_down_demo3.dart';
import 'drop_down_demo4.dart';
import 'drop_down_demo5.dart';
import 'drop_down_demo_button.dart';
import 'drop_down_demo_taobao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropDownDemo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

Map<String, Widget> routes = {
  "DropDownDemo Overlay": const DropDownDemo1(),
  "DropDownDemo List & Grid": const DropDownDemo2(),
  "DropDownDemo Custom": const DropDownDemo3(),
  "DropDownDemo CustomScrollView": const DropDownDemo4(),
  "DropDownDemo Custom DropDownView": const DropDownDemo5(),
  "DropDownDemo Taobao": const DropDownDemoTaobao(),
  "DropDownDemo Button": const DropDownDemoButton(),
};

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor:
                index % 2 == 0 ? Colors.grey.shade300 : Colors.grey.shade200,
            title: Text(routes.keys.elementAt(index)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return routes.values.elementAt(index);
              }));
            },
          );
        },
      ),
    );
  }
}
