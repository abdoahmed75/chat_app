import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/utils/image_urls.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double height;
  final double width;

  CustomCachedNetworkImage({
    required this.imgUrl,
    this.width = 220,
    this.height = 280,
  });

  final List<String> _imageFormats = [
    '.jpeg',
    '.png',
    '.jpg',
    '.gif',
    '.webp',
    '.tif',
    '.heic'
  ];

  bool _isImage(String path) {
    bool output = false;
    _imageFormats.forEach((imageFormat) {
      if (path.toLowerCase().contains(imageFormat)) output = true;
    });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return _isImage(imgUrl)
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                gradient: AppConstants.K_GRADIENT_COLOR,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        0.0,
                        1.0,
                      ),
                      blurRadius: 100.0,
                      spreadRadius: 5.0),
                ]),
            child: Image.asset(
              ImageUrls.IMAGE_NOT_FOUND,
              fit: BoxFit.cover,
            ),
          )
        : CachedNetworkImage(
            placeholder: (context, url) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gradient: AppConstants.K_GRADIENT_COLOR,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(
                          0.0,
                          1.0,
                        ),
                        blurRadius: 100.0,
                        spreadRadius: 5.0),
                  ]),
              child: Center(
                child: SpinKitThreeBounce(
                  size: 30,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.all(70.0),
            ),
            height: height,
            width: width,
            imageUrl: imgUrl,
            fit: BoxFit.cover,
          );
  }
}
