import 'package:flutter/material.dart';

class YourWidget extends StatefulWidget {
  const YourWidget({Key? key}) : super(key: key);

  @override
  State<YourWidget> createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {

  AlertDialog alert = AlertDialog(content: Center(child:Text("Second Alert Dialog")));

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: (){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Column(
                children: <Widget>[
                  RaisedButton( onPressed: (){
                    showDialog(context: context, builder: (_) => alert);
                  }),
                  RaisedButton(onPressed: (){
                    showDialog(context: context, builder: (_) => alert);
                  }),
                ],
              );
            }
          ),
        )
      );
    });
  }
}
