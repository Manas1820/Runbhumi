import 'dart:async';
import 'package:Runbhumi/utils/Constants.dart';
import 'package:Runbhumi/view/profile/profileFriendsList.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../views.dart';
import '../../widget/widgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  //toggle for drawer(menu)
  void toggle() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
    print("menu toggle");
  }

  //distance for profile to move right when the drawer is opened
  //variables for drawer animations
  static const double maxSlide = 250.0;

  @override
  Widget build(BuildContext context) {
    var myDrawer = SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            // to close drawer
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Feather.x,
                    color: Colors.white,
                  ),
                  onPressed: toggle,
                );
              },
            ),
          ),
          body: DrawerBody(),
        ),
      ),
    );
    var myChild = DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: buildTitle(context, "Profile"),
          centerTitle: true,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Feather.menu,
                ),
                onPressed: toggle,
              );
            },
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(child: Text("Profile")),
              Tab(child: Text("Friends")),
              Tab(child: Text("Schedule")),
            ],
            indicator: new BubbleTabIndicator(
              indicatorHeight: 30.0,
              indicatorColor: Theme.of(context).primaryColor,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
        body: ProfileBody(),
      ),
    );
    return GestureDetector(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = maxSlide * animationController.value;
          double scale = 1 - (animationController.value * 0.3);
          return Stack(
            children: [
              myDrawer,
              Transform(
                child: myChild,
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({
    Key key,
  }) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final db = FirebaseFirestore.instance;
  StreamSubscription sub;
  Map data;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    sub = db
        .collection('users')
        .doc(Constants.prefs.getString('userId'))
        .snapshots()
        .listen((snap) {
      setState(() {
        data = snap.data();
        _loading = true;
      });
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    MainUserProfile(data: data),
                    ProfileFriendsList(),
                    Schedule(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Loader();
    }
  }
}

class MainUserProfile extends StatelessWidget {
  const MainUserProfile({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //profile image
        if (data['profileImage'] != null)
          Container(
            width: 125,
            height: 125,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              image: DecorationImage(
                image: NetworkImage(data['profileImage']),
                fit: BoxFit.contain,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x44393e46),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
          ),
        //Name
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            data['name'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        //Bio
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            left: 32.0,
            right: 32.0,
          ),
          child: Center(
            child: Text(
              data['bio'],
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        //stats
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            width: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            data['eventCount'].toString(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Text("events"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            data['teamsCount'].toString(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Text("teams"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            data['friendCount'].toString(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Text("friends"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        //details
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (data["age"] != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Feather.user,
                          size: 24.0,
                        ),
                      ),
                      Text(
                        data["age"],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                if (data["location"] != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Feather.map_pin,
                          size: 24.0,
                        ),
                      ),
                      Text(
                        data["location"],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Feather.mail,
                        size: 24.0,
                      ),
                    ),
                    Text(
                      data["emailId"],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (data['phoneNumber']['show'])
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Feather.phone,
                          size: 24.0,
                        ),
                      ),
                      Text(
                        data['phoneNumber']['ph'],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*
Text Spanning can be used to give user a feeling of auto completion
*/
