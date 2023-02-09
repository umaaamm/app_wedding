import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Animated Navigation Bottom Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.qr_code_scanner_outlined,
    Icons.list_alt_outlined,
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#FFFFFF'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        extendBody: true,
        // appBar: RoundAppBar(title: 'My Wedding'),
        backgroundColor: Colors.white,
        // body: NotificationListener<ScrollNotification>(
        //   onNotification: onScrollNotification,
        //   child: NavigationScreen(iconList[_bottomNavIndex]),
        // ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 200,
              child: RoundAppBar(
                title: 'My Wedding',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Card(
                child: Container(
                  height: 85,
                  child: Row(
                    children: [
                      Container(
                        padding: new EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total Hadir",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik-Semi'),
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik-Semi',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: new EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Belum Hadir",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik-Semi'),
                            ),
                            Text(
                              "40",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik-Semi',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: new EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total Undangan",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik-Semi'),
                            ),
                            Text(
                              "200",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik-Semi',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // height: 300,
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Container(
                child: SizedBox.expand(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          height: 100,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            // gradient: LinearGradient( colors: [Color(0xff3fbc63), Color(0xffffffff)], begin: Alignment.bottomRight, end: Alignment.topLeft),
                            gradient: LinearGradient(
                              colors: [Color(0x733fbc63), Color(0xffffffff)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                              borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage("https://raw.githubusercontent.com/umaaamm/image-icon-dance/fc653e21f8bb005fb77955bf3ab7e705b5316847/dance.png"),
                              fit: BoxFit.fitHeight,
                              alignment: FractionalOffset.centerRight,
                            opacity: 0.1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Yoga Tomi Nyoto",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Rubik-Bold', fontSize: 18),
                                    ),
                                    Text("Hadir",
                                        style: TextStyle(
                                            color: HexColor("#00883E"),
                                            fontFamily: 'Rubik-Semi',
                                            fontWeight: FontWeight.bold)),
                                    Text("10-11-2023 - 13.00 WIB",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'Rubik-Semi',
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      print("mwkwm");
                                    },
                                    child: Text(
                                      "Get Marchendise",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        backgroundColor: MaterialStateProperty.all<Color>(HexColor("#00883E")),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                )))),
                              ],
                            ),
                          ),
                        ),
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                      );
                      // );
                    },
                  ),
                ),
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                color: Colors.white,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor('#40BD63'),
          child: Icon(
            Icons.qr_code_scanner_outlined,
            color: HexColor('#FFFFFF'),
          ),
          onPressed: () {
            _fabAnimationController.reset();
            _borderRadiusAnimationController.reset();
            _borderRadiusAnimationController.forward();
            _fabAnimationController.forward();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? HexColor('#00662E') : HexColor("#40BD63");
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 32,
                  color: color,
                ),
              ],
            );
          },
          backgroundColor: HexColor('#FFFFFF'),
          activeIndex: _bottomNavIndex,
          splashColor: HexColor('#40BD63'),
          notchAndCornersAnimation: borderRadiusAnimation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          hideAnimationController: _hideBottomBarAnimationController,
        ),
      ),
    );
  }

  // _buildBody() {
  //   return
  // }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  NavigationScreen(this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          SizedBox(height: 64),
          Center(
            child: CircularRevealAnimation(
              animation: animation,
              centerOffset: Offset(80, 80),
              maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
              child: Icon(
                widget.iconData,
                color: HexColor('#40BD63'),
                size: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class RoundAppBar extends StatelessWidget with PreferredSizeWidget {
  final double barHeight = 100;
  final String title;
  RoundAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title: Center(child: Text(title)),
      title: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontFamily: 'Rubik-Bold', fontSize: 28),
        ),
      ),
      leading: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(
                    'https://awsimages.detik.net.id/community/media/visual/2020/10/12/ilustrasi-pernikahan.jpeg?w=700&q=90'),
                fit: BoxFit.fill),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.qr_code_scanner_outlined),
          onPressed: () {
            print('Click Scan');
          },
        ),
      ],
      backgroundColor: HexColor('#00AB4E'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
      ),
    );
  }
}
