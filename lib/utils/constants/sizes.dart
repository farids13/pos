import 'package:flutter/material.dart';

class QSizes {
  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Padding and Margin Sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Icon Sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  //Font Sizes

  static const double fontSizesSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

// Button Sizes
  static const double buttonHeight = 60.0;
  static const double buttonRadius = 12.0;
  static const double buttonWidth = 120.0;
  static const double buttonElevation = 4.0;

// AppBar Height
  static const double appBarHeight = 56.0;

//Image Size
  static const double imageThumbSize = 80.0;

// Default spacing between sections
  static const double defaultSpace = 24.0;
  static const double spaceBetweenItems = 16.0;
  static const double spaceBetweenSections = 32.0;

// Border Radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;

// Divider height
  static const double dividerHeight = 1.0;

// Product item dimensions

  static const double productImageSize = 120.0;
  static const double productImageRadius = 16.0;
  static const double productItemHeight = 160.0;

//Input Field
  static const double inputFieldRadius = 12.0;
  static const double spaceBetweenInputFields = 16.0;

// Card Sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;

// Image Carousel height
  static const double imageCarouselHeight = 200.0;

// Loading Indicator size
  static const double loadingIndicatorSize = 36.0;

// Grid view Spacing
  static const double gridViewSpacing = 16.0;
}
