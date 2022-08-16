import 'package:flutter/widgets.dart';

double width(BuildContext context){
  return MediaQuery.of(context).size.width;
}

//MediaQuery.of(context).size.height;
double height(BuildContext context){
  return MediaQuery.of(context).size.height;
}