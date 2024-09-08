/*
 
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:wahiddarbar/core/models/common_models/image_model.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/widgets/images_viewer.dart';

class Utils {
  static createSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static convertListImageToListCachedImage(List<ImageModel> list) {
    var images = List<CachedNetworkImage>();
    for (var item in list) {
      images.add(CachedNetworkImage(
        imageUrl: item.src,
        placeholder: (context, url) => SpinKitRing(
          color: ThemeColors.Fb,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ));
    }
    return images;
  }

  static convertListImageToListString(List<ImageModel> list) {
    var images = List<String>();
    for (var item in list) {
      images.add(item.src);
    }
    return images;
  }

  static createCachedImage({String imageUrl, bool rounded = false}) {
    var image = CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => SpinKitRing(
        color: ThemeColors.Fb,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
    var roundedImage = ClipRRect(
      child: image,
      borderRadius: BorderRadius.circular(15),
    );
    return rounded ? roundedImage : image;
  }

  static createAssetImage({String imageUrl}) {
    var image = Image.asset(imageUrl);
    return image;
  }

  static createImageBox({
    BuildContext context,
    double width,
    double height,
    List<ImageModel> images,
    BorderRadius radius,
  }) {
    if (radius == null) {
      radius = BorderRadius.circular(15.0);
    }
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: radius,
        child: (() {
          if (images.length < 1) {
            return createAssetImage(imageUrl: ImageModel.image().src);
          } else {
            return Carousel(
              images: convertListImageToListCachedImage(images),
              autoplay: true,
              showIndicator: false,
              onImageTap: (i) {
                pushNewScreen(
                  context,
                  screen: ImagesViewer(
                    images: convertListImageToListString(images),
                    index: i,
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            );
          }
        }()),
      ),
    );
  }

  static createSingleAssetImageBox(
      {double width, double height, String image, BorderRadius radius}) {
    if (radius == null) {
      radius = BorderRadius.circular(15.0);
    }
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: radius,
        child: Image.asset(image),
      ),
    );
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }
}
