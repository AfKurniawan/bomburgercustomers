import 'dart:math';

import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/widget/OrderItemWidget.dart';
import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  Cart track;

  TrackingPage({Key key, this.track}) : super (key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {

  int _currentStep = Random().nextInt(4);

  List cartlist;

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        state: StepState.complete,
        title: Text(
          'Order Received',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          '16:30 - Your order got confirmed',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 0,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'Preparing',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          '16:40 - We start pereparing your dish',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 1,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'Cooking',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          '16:50 - We are started cooking the food',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 2,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'It\'s Ready',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          'Start to deliver your order',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 3,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'Delivered',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          'Enjoy your meal, and have great day',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 4,
      )
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Tracking Order',
            style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                            image: NetworkImage(ApiUrl.imgUrl + widget.track.picture),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.track.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                SizedBox(height: 20),
                                widget.track.status == 'onCheckout'
                                    ? Text(
                                  "Processed",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.green),
                                )
                                    :  widget.track.status == 'onCart'
                                    ? Text(
                                  "In Your Cart",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.deepOrange),
                                )
                                    : Text(
                                  widget.track.status,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("RM ${widget.track.price}",
                                  style: Theme.of(context).textTheme.display1),
                              SizedBox(height: 20),
                              Text(
                                widget.track.date,
                                style: Theme.of(context).textTheme.caption,
                              ),
//                              Text(
//                                timeValue,
//                                style: Theme.of(context).textTheme.caption,
//                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),
              Theme(
                data: ThemeData(
                  primaryColor: Theme.of(context).accentColor,
                ),
                child: Stepper(
                  controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                    return SizedBox(height: 0);
                  },
                  steps: _mySteps(),
                  currentStep: this._currentStep,
                ),
              ),
            ],
          ),
        ));
  }
}
