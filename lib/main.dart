import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skrtuvideo/component/mybutton.dart';

import 'component/mygrid_view.dart';
import 'component/mytabbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skr兔',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Skr 兔'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _indexTabValues = [];
  final List<String> _videoTabValues = [];
  TabController _controller;
  final List<Widget> _bodyViewList = [];
  final List<List<String>> _topViewList = [];
  int _selected = 0;
  String imgPath = 'imgs/';

  void _changeIndex(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _indexTabValues.addAll([
      '关注',
      '推荐',
    ]);
    _videoTabValues.addAll([
      '视频',
      '短视频',
    ]);
    _topViewList.add(_indexTabValues);
    _topViewList.add(_videoTabValues);
    _controller = TabController(
      length: _indexTabValues.length,
      vsync: ScrollableState(),
    );
    //首页
    _bodyViewList.add(Center(
      child: TabBarView(
        controller: _controller,
        children: <Widget>[MyGridView(), MyTabBar()],
      ),
    ));
    //视频
    _bodyViewList.add(MyGridView());
  }

  //首页标题
  TabBar getTabBar() {
    return TabBar(
      controller: _controller, //控制器
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _topViewList[_selected].map((e) {
        return Container(
          height: 50,
          width: 80,
          alignment: Alignment.center,
          child: Text(e),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: 10,
              height: 10,
              child: GestureDetector(
                child: Image.asset(
                  'imgs/img_default.png',
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        automaticallyImplyLeading: false,
        title: getTabBar(),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: myDrawer(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            MyFlatButton(
              text: '首页',
              img: _selected == 0
                  ? imgPath + 'index1_select.png'
                  : imgPath + 'index1.png',
              textColor: _selected == 0 ? Colors.green : Colors.black54,
              onPress: () => {_changeIndex(0)},
            ),
            MyFlatButton(
              text: '视频',
              img: _selected == 1
                  ? imgPath + 'video_select.png'
                  : imgPath + 'video.png',
              textColor: _selected == 1 ? Colors.green : Colors.black54,
              onPress: () => {_changeIndex(1)},
            ),
            SizedBox(), //中间位置空出
            MyFlatButton(
              text: '消息',
              img: _selected == 2
                  ? imgPath + 'msg_select.png'
                  : imgPath + 'msg.png',
              textColor: _selected == 2 ? Colors.green : Colors.black54,
              onPress: () => {_changeIndex(2)},
            ),
            MyFlatButton(
              text: '我的',
              img: _selected == 3
                  ? imgPath + 'me_select.png'
                  : imgPath + 'me.png',
              textColor: _selected == 3 ? Colors.green : Colors.black54,
              onPress: () => {_changeIndex(3)},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: null),
      body: _bodyViewList[_selected],
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Drawer myDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Text("抽屉头部"),
              decoration: BoxDecoration(color: Colors.green)),
          ListTile(
            title: Text('第一行'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('第二行'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}