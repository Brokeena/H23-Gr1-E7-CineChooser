import 'dart:ui';
import 'package:flutter/material.dart';

class Styles

{
  static const Color bgColor =  Color(0xff09080C);
  static const Color white1 =  Color(0xffEDF2F4);
  static const Color grey1 =  Color(0xff8D99AE);
  static const Color red1 =  Color(0xffCF313A);
  static const Color red2 =  Color(0xffFC171F);
  static const TextStyle nom_de_pages = TextStyle(fontWeight: FontWeight.normal, fontSize: 21, color: Colors.white);
  static const TextStyle petittitres = TextStyle(color: Colors.white,fontWeight: FontWeight.normal);
  static const TextStyle entete = TextStyle(color: Colors.white,fontWeight: FontWeight.normal);
  static const TextStyle preTitre = TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white);
  static const TextStyle titre = TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Styles.red2);
  static const TextStyle informations = TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white38);
  static const TextStyle bouton = TextStyle(fontWeight:  FontWeight.w800, fontSize: 20, color: Styles.red1);
  static TextStyle nom = const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: white1);
  static TextStyle genres = const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: red1);

}