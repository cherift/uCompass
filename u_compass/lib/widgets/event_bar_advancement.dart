import 'package:flutter/material.dart';

class BarAdvancementWidget extends StatelessWidget {
  final double done;
  final double todo;

  BarAdvancementWidget(this.done, this.todo);

  @override
  Widget build(BuildContext context) {
    if (this.done == 0)
      return completelyToDo();
    else if (this.todo == 0)
      return completelyDone();
    else
      return Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: Colors.black, width: 4, style: BorderStyle.solid)),
            child: Text(''),
          ),
          Container(
            height: todo * 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: Colors.green, width: 4, style: BorderStyle.solid)),
            child: Text(''),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(0, todo * 40, 0, 0),
            height: 13,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: null,
            ),
          ),
        ],
      );
  }

  Widget completelyToDo() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: Colors.black, width: 4, style: BorderStyle.solid)),
          child: Text(''),
        )
      ],
    );
  }

  Widget completelyDone() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: Colors.green, width: 4, style: BorderStyle.solid)),
          child: Text(''),
        )
      ],
    );
  }
}
