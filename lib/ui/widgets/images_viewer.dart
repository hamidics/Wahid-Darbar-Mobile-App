/*
 
 */

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagesViewer extends StatefulWidget {
  ImagesViewer({
    this.index,
    @required this.images,
  }) : pageController = PageController(initialPage: index);

  final int index;
  final List<String> images;
  final pageController;

  @override
  _ImagesViewerState createState() => _ImagesViewerState();
}

class _ImagesViewerState extends State<ImagesViewer> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('بازگشت'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: PhotoViewGallery.builder(
                  itemCount: widget.images.length,
                  pageController: widget.pageController,
                  builder: _buildItem,
                  onPageChanged: onPageChanged,
                  scrollPhysics: BouncingScrollPhysics(),
                  // Set the background color to the "classic white"
                  backgroundDecoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DotsIndicator(
                dotsCount: widget.images.length,
                position: currentIndex.toDouble(),
                decorator: DotsDecorator(
                  color: Colors.black87,
                  activeColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String image = widget.images[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
        image,
      ),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.2,
    );
  }
}
