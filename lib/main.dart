import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';


void main() {
  enableFlutterDriverExtension();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Demo app", home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final List<String> heads = [
    'マンガ',
    'タイズ',
    'どうぶつ',
    '料理',
    'スポーツ',
    '映画',
    '音楽',
  ];
  final List<String> contents = [
    'マンガ',
    'タイズ',
    'どうぶつ',
    '料理',
    'スポーツ',
    '映画',
    '音楽',
    'マンガ',
    'タイズ',
    'どうぶつ',
    '料理',
    'スポーツ',
    '映画',
    '音楽'
  ];

  late ScrollController _scrollController;
  late TabController _tabController;
  late int index = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: heads.length);
  }

  void toTop() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void toBottom() {
    if (_scrollController.offset == 0) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: heads.length,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Demo app"),
            ),
            body: Column(children: [
              SizedBox(
                height: 50,
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 200.0,
                      disableCenter: true,
                      pageSnapping: false,
                      padEnds: false,
                      viewportFraction: 0.2),
                  items: heads.asMap().entries.map((MapEntry e) {
                    bool selected = e.key == _tabController.index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _tabController.animateTo(e.key);
                          index = e.key;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                            color:
                                (selected ? Color(0xFFFFE082) : Colors.amber)),
                        child: Column(
                          children: [
                            const Spacer(),
                            Text(
                              e.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: selected ? Colors.red : Colors.black),
                            ),
                            const Spacer(),
                            if (selected)
                              Container(
                                height: 2,
                                color: Colors.red,
                              )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
               Container(
                  decoration: const BoxDecoration(
                      color:Colors.blueGrey),
                height: 40,
                child: Center(child: Text("DEMO ${_tabController.index}", textAlign: TextAlign.center))
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: TabBarView(
                      controller: _tabController,
                      children: heads
                          .map((i) => GestureDetector(
                              onHorizontalDragEnd: (DragEndDetails drag) {
                                if (drag.primaryVelocity == null) return;
                                if (drag.primaryVelocity! < 0) {
                                  toTop();
                                } else {
                                  toBottom();
                                }
                              },
                              child: CustomScrollView(
                                controller: _scrollController,
                                slivers: <Widget>[
                                  SliverGrid(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5.0,
                                      crossAxisSpacing: 5.0,
                                      childAspectRatio: 1.1,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return Container(
                                          height: 200,
                                          alignment: Alignment.center,
                                          color:
                                              Colors.teal[100 * (index % 10)],
                                          child: Text(
                                              'Grid Item ${contents[index]}'),
                                        );
                                      },
                                      childCount: contents.length,
                                    ),
                                  ),
                                ],
                              )))
                          .toList()),
                ),
              )
            ])));
  }
}
