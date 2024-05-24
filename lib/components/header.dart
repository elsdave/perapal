import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          centerTitle: true,
          title: Image.asset('assets/logo1.png', height: 80,),
          backgroundColor: textLight,
          elevation: 200,
    );
  }
}