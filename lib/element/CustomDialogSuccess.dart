


import 'package:bomburger301219/config/app_config.dart';
import 'package:bomburger301219/models/payment.dart';
import 'package:bomburger301219/page/pager.dart';
import 'package:flutter/material.dart';

class CustomDialogSuccess extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  String radioItem = 'Mango';

  // Group Value for Radio Button.
  int id = 1;


  List<Payment> payment = [
    Payment(
      index: 1,
      name: "Mango",
    ),
    Payment(
      index: 2,
      name: "Apple",
    ),
    Payment(
      index: 3,
      name: "Banana",
    ),

  ];

  CustomDialogSuccess({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
               // color: Theme.of(context).primaryColorDark,
                color: Colors.black12,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[

              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                    Navigator.of(context).pushNamed('/Pages', arguments: 2);
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            child: Image.asset(
              'assets/img/icon_success.png',
              width: 90,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }
}