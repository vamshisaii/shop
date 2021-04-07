import 'package:flutter/material.dart';

var textDecoration=InputDecoration(
            filled: true,
            fillColor: Colors.white54,
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 1.0,
              ),
            ),
            labelText: "Search",
            prefixIcon: Icon(Icons.search),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
          );