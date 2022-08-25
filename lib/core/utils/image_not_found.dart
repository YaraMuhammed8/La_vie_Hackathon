import 'package:flutter/material.dart';

Widget imageNotFound(context, object, stacktrace, {double size = 100}) =>
    Center(
      child: Icon(
        Icons.image_outlined,
        size: size,
        color: Colors.grey.shade300,
      ),
    );