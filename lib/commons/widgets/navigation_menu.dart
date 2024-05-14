import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/formatters/formatter.dart';
import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

//? Function For Item In CurvedNavigationBar
class CustomBottomBarItem {
  final IconData iconData;
  final IconData? selectedIconData;
  final String? label;

  CustomBottomBarItem(
      {required this.iconData, this.selectedIconData, this.label});
}

// Main Bottom Navigation
class CustomBottomBar extends ConsumerWidget {
  const CustomBottomBar(
      {super.key,
      required this.items,
      required this.onTap,
      this.selectedColor = const Color(0xff0D6EFD),
      this.unselectedColor = Colors.black,
      this.currentIndex = 0})
      : assert(
          items.length == 4,
          'Please Use 4 widget Option Only. '
          'depends on its items being exactly 4',
        );

  final List<CustomBottomBarItem> items;
  final ValueChanged<int>? onTap;
  final Color unselectedColor;
  final Color selectedColor;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    // ignore: sized_box_for_whitespace
    return Container(
      color: QHelperFunction.isDarkMode(context)
          ? QColors.dark
          : QColors.lightGrey,
      height: 80,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              child: Stack(
                children: [
                  Center(
                    heightFactor: .0,
                    child: Container(
                      height: size.width * 0.15 < 90 ? size.width * 0.15 : 100,
                      width: size.width * 0.15 < 90 ? size.width * 0.15 : 100,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(180)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        child: FloatingActionButton(
                          backgroundColor: QColors.primary,
                          elevation: 4.0,
                          onPressed: () {
                            GoRouter.of(context).push("/scan");
                          },
                          shape: const CircleBorder(),
                          child:
                              const Icon(Iconsax.scanner, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //? icons

                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        items.length,
                        (index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: QSizes.defaultSpace - 10,
                              left: QSizes.defaultSpace - 10,
                              right: QSizes.defaultSpace - 10,
                            ),
                            child: IconButton(
                              onPressed: () => onTap?.call(index),
                              color: index == currentIndex
                                  ? selectedColor
                                  : unselectedColor,
                              icon: Column(
                                children: [
                                  Icon(
                                    size: size.width * 0.05 < 30
                                        ? size.width * 0.05
                                        : 30,
                                    index == currentIndex
                                        ? item.selectedIconData ?? item.iconData
                                        : item.iconData,
                                  ),
                                  Text(
                                    item.label ?? '',
                                    style: TextStyle(
                                        fontSize: size.width * 0.025 < 12
                                            ? size.width * 0.025
                                            : 12,
                                        color: index == currentIndex
                                            ? selectedColor
                                            : unselectedColor),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )..insert(2, SizedBox(width: size.width * 0.08)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//? NavBar Clipper Function
class _CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, -30); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.elliptical(6, 4), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, -30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, -30);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
