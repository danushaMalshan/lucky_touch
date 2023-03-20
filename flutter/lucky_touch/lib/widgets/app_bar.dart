import 'package:flutter/material.dart';

PreferredSize CustomAppBar(String title) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.amberAccent.withOpacity(0.3),
      centerTitle: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
