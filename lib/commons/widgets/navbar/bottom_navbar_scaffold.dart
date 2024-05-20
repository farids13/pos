import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/widgets/navbar/controller/bottom_navigation_controller.dart';
import 'package:cashier_app/commons/widgets/navbar/custom_navbar.dart';
import 'package:cashier_app/modules/dashboard/utils/dashboard_utils.dart';
import 'package:cashier_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  final Widget child;
  const ScaffoldWithNavBar(this.child, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<ScaffoldWithNavBar> {
  @override
  Widget build(BuildContext context) {
    final indexPosition = ref.watch(selectIndexStateProvider);
    final size = MediaQuery.of(context).size;

    String username = '';

    Future<void> getUsername() async {
      final pref = await SharedPreferences.getInstance();
      username = pref.getString("username") ?? "";
    }

    getUsername();

    return Scaffold(
      extendBody: true,
      body: widget.child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: size.width * 0.15 < 90 ? size.width * 0.15 : 100,
        width: size.width * 0.15 < 90 ? size.width * 0.15 : 100,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(180)),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: QColors.primary,
          elevation: 4.0,
          hoverColor: QColors.accent,
          onPressed: () {
            // GoRouter.of(context).push("/login");
            DashboardUtils.createNewReceipt(
                ref, context, "SLS", JournalType.sale);
          },
          shape: const CircleBorder(),
          child: const Icon(Iconsax.scanner, color: Colors.white),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 2,
        child: CustomBottomBar(
          items: [
            CustomBottomBarItem(
                iconData: Iconsax.home,
                selectedIconData: Iconsax.home,
                label: "Home"),
            CustomBottomBarItem(
                iconData: Iconsax.heart,
                selectedIconData: Iconsax.heart,
                label: "Product"),
            CustomBottomBarItem(
                iconData: Iconsax.blend,
                selectedIconData: Iconsax.blend,
                label: "Transaction"),
            CustomBottomBarItem(
                iconData: Iconsax.user,
                selectedIconData: Iconsax.user,
                label: "Profile"),
          ],
          currentIndex: indexPosition,
          onTap: (indexPosition) => _onTap(
            indexPosition,
            username,
          ),
        ),
      ),
    );
  }

  void _onTap(int index, String username) {
    ref.watch(selectIndexStateProvider.notifier).setIndexPosition(index);
    switch (index) {
      case 0:
        context.go("/home/$username");
        break;
      case 1:
        context.go("/productList");
        break;
      case 2:
        context.go("/transaction");
        break;
      case 3:
        context.go("/profile");
        break;
      default:
    }
  }
}
