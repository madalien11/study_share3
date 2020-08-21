import 'package:flutter/material.dart';

const kSearchFieldDecoration = InputDecoration(
  hintText: 'Search',
  hintStyle: TextStyle(color: Color(0xff828282), fontSize: 20),
  fillColor: Color(0xffffffff),
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffD3D3D3), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffD3D3D3), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
);
