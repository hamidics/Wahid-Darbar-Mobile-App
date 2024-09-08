/*
 
 */

import 'package:wahiddarbar/core/utilities/static_methods.dart';

class ImageModel {
  int id;
  String src;
  String name;
  String alt;

  ImageModel();

  ImageModel.set({this.id, this.src, this.name, this.alt});

  ImageModel.image({this.src = 'asset/images/no-image.png'});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel.set(
        id: SM.toInt(json['id']),
        src: SM.toStr(json['src']),
        name: SM.toStr(json['name']),
        alt: SM.toStr(json['alt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'src': src,
        'name': name,
        'alt': alt,
      };
}
