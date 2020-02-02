import 'package:flutter/material.dart';

class BarAdvancementWidget extends StatelessWidget {

  final double done;
  final double todo;

  BarAdvancementWidget(this.done,this.todo);

  @override
  Widget build(BuildContext context) {
    if(this.done==0)return completelyToDo();
    else if(this.todo==0) return completelyDone();
    else return   Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: Colors.black,
                  width: 3,
                  style: BorderStyle.solid)),
          child: Text(''),
        ),
        Container(
          height: todo * 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: Colors.green,
                  width: 3,
                  style: BorderStyle.solid)),
          child: Text(''),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, todo*40, 0, 0),
          height: 10,
          child: CircleAvatar(
            backgroundColor: Colors.purple,
            child: null,
          ),
        ),
      ],
    );
  }


  Widget completelyToDo() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: Colors.black,
              width: 3,
              style: BorderStyle.solid)),
      child: Text(''),
    );
  }
    Widget completelyDone(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: Colors.green,
                width: 3,
                style: BorderStyle.solid)),
        child: Text(''),
      );


  }
}
