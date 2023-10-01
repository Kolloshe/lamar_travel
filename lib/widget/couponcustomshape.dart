
import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.8843612,size.height*0.3928127);
    path_0.arcToPoint(Offset(size.width*0.9218750,size.height*0.3469124),radius: Radius.elliptical(size.width*0.04698270, size.height*0.04698270),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.9218750,size.height*0.2500000);
    path_0.arcToPoint(Offset(size.width*0.8750000,size.height*0.2031250),radius: Radius.elliptical(size.width*0.04692625, size.height*0.04692625),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.1250000,size.height*0.2031250);
    path_0.arcToPoint(Offset(size.width*0.07812500,size.height*0.2500000),radius: Radius.elliptical(size.width*0.04692625, size.height*0.04692625),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.07812500,size.height*0.3469124);
    path_0.arcToPoint(Offset(size.width*0.1156387,size.height*0.3928127),radius: Radius.elliptical(size.width*0.04698270, size.height*0.04698270),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.arcToPoint(Offset(size.width*0.1156387,size.height*0.6071873),radius: Radius.elliptical(size.width*0.1094055, size.height*0.1094055),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*0.07812500,size.height*0.6530876),radius: Radius.elliptical(size.width*0.04698270, size.height*0.04698270),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.07812500,size.height*0.7500000);
    path_0.arcToPoint(Offset(size.width*0.1250000,size.height*0.7968750),radius: Radius.elliptical(size.width*0.04692625, size.height*0.04692625),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.8750000,size.height*0.7968750);
    path_0.arcToPoint(Offset(size.width*0.9218750,size.height*0.7500000),radius: Radius.elliptical(size.width*0.04692625, size.height*0.04692625),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*0.9218750,size.height*0.6530876);
    path_0.arcToPoint(Offset(size.width*0.8843612,size.height*0.6071873),radius: Radius.elliptical(size.width*0.04698270, size.height*0.04698270),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.arcToPoint(Offset(size.width*0.8843612,size.height*0.3928127),radius: Radius.elliptical(size.width*0.1094055, size.height*0.1094055),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.close();
    path_0.moveTo(size.width*0.1093750,size.height*0.7500000);
    path_0.lineTo(size.width*0.1093750,size.height*0.6530876);
    path_0.arcToPoint(Offset(size.width*0.1218567,size.height*0.6378136),radius: Radius.elliptical(size.width*0.01563324, size.height*0.01563324),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*0.1218567,size.height*0.3621864),radius: Radius.elliptical(size.width*0.1406569, size.height*0.1406569),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.arcToPoint(Offset(size.width*0.1093750,size.height*0.3469124),radius: Radius.elliptical(size.width*0.01563324, size.height*0.01563324),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*0.1093750,size.height*0.2500000);
    path_0.arcToPoint(Offset(size.width*0.1250000,size.height*0.2343750),radius: Radius.elliptical(size.width*0.01564168, size.height*0.01564168),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*0.3593750,size.height*0.2343750);
    path_0.lineTo(size.width*0.3593750,size.height*0.7656250);
    path_0.lineTo(size.width*0.1250000,size.height*0.7656250);
    path_0.arcToPoint(Offset(size.width*0.1093750,size.height*0.7500000),radius: Radius.elliptical(size.width*0.01564168, size.height*0.01564168),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.close();
    path_0.moveTo(size.width*0.7656250,size.height*0.5000000);
    path_0.arcToPoint(Offset(size.width*0.8781433,size.height*0.6378136),radius: Radius.elliptical(size.width*0.1410086, size.height*0.1410086),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.arcToPoint(Offset(size.width*0.8906250,size.height*0.6530876),radius: Radius.elliptical(size.width*0.01563324, size.height*0.01563324),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*0.8906250,size.height*0.7500000);
    path_0.arcToPoint(Offset(size.width*0.8750000,size.height*0.7656250),radius: Radius.elliptical(size.width*0.01564168, size.height*0.01564168),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*0.3906250,size.height*0.7656250);
    path_0.lineTo(size.width*0.3906250,size.height*0.2343750);
    path_0.lineTo(size.width*0.8750000,size.height*0.2343750);
    path_0.arcToPoint(Offset(size.width*0.8906250,size.height*0.2500000),radius: Radius.elliptical(size.width*0.01564168, size.height*0.01564168),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*0.8906250,size.height*0.3469124);
    path_0.arcToPoint(Offset(size.width*0.8781433,size.height*0.3621864),radius: Radius.elliptical(size.width*0.01563324, size.height*0.01563324),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*0.7656250,size.height*0.5000000),radius: Radius.elliptical(size.width*0.1410086, size.height*0.1410086),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.close();

    Paint paint0Fill = Paint()..style=PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0,paint0Fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}