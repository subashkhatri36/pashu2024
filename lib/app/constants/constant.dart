import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/images.dart';
import 'package:pasuhisab/app/data/model/category.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/data/model/dana_type.dart';

const double borderRadius = 20.0;
//ca-app-pub-5946802346170399/4371243591

List<Category> challaCategoryList = [
  new Category(id: 1, categoryname: boiler.tr, image: boilerimage),
  new Category(id: 2, categoryname: parent.tr, image: parentimage),
  new Category(id: 3, categoryname: bhale.tr, image: bhaleimage),
  new Category(id: 4, categoryname: turkey.tr, image: trukeyimage),
  new Category(id: 5, categoryname: quail.tr, image: kataknathimage),
  new Category(id: 6, categoryname: kadaknath.tr, image: kataknathimage),
];
List<DanaType> danaTypeList = [
  new DanaType(id: 1, danaType: 'B0'),
  new DanaType(id: 2, danaType: 'B1'),
  new DanaType(id: 3, danaType: 'B2'),
  new DanaType(id: 4, danaType: 'L3'),
];
