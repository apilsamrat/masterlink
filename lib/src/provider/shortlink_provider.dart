import 'package:flutter/material.dart';
import 'package:masterlink/src/modal/modal.dart';

class ShortLinkProvider with ChangeNotifier{
ShortData? data;

set setShortData(ShortData data)=> this.data;

get getShortData => data;

}