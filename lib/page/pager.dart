import 'package:bomburger301219/element/drawer.dart';
import 'package:bomburger301219/page/cart.dart';
import 'package:bomburger301219/page/history.dart';
import 'package:bomburger301219/page/home.dart';
import 'package:flutter/material.dart';

class Pager extends StatefulWidget {

  int currentTab;
  String currentTitle;
  Widget currenPage = new HomePage();

  Pager({Key key, this.currentTab}){
    currentTab = currentTab != null ? currentTab : 1 ;
  }



  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {


  @override
  void initState() {
    selectTab(widget.currentTab);
    super.initState();
  }

  @override
  void didUpdateWidget(Pager oldWidget){
    selectTab(oldWidget.currentTab);
  }

  void selectTab(int tabItem){
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0 :
          widget.currentTitle = "Cart";
          widget.currenPage = CartPage();
          break;

        case 1 :
          widget.currentTitle = "Home";
          widget.currenPage = HomePage();
          break;

        case 2 :
          widget.currentTitle = "History";
          widget.currenPage = HistoryPage();
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Text(widget.currentTitle,
        style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: widget.currenPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i){
            selectTab(i);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink),
              title: Container(height: 0)
            ),

            BottomNavigationBarItem(
              title: new Container(height: 5.0),
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 40,
                        offset: Offset(0, 15),
                      ),
                      BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3),
                      ),
                    ]
                ),
                child: new Icon(Icons.home,
                    color: Theme.of(context).primaryColor),
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              title: new Container(height: 0.0),
            ),

          ]),
    );
  }
}
