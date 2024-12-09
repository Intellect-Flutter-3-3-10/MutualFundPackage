import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../my_app_exports.dart';
import '../res/res.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    super.key,
  });

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    DiscoverScreen(),
    WatchListScreen(),
    MyPortFolioScreen(),
    OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint(" screen width >>>>> ${MediaQuery.of(context).size.width}");
    debugPrint(" screen height >>>>> ${MediaQuery.of(context).size.height}");
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyles.semiBold13(),
        enableFeedback: true,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: isDark ? AppColor.offWhite : AppColor.greyLightest,
        selectedItemColor: AppColor.lightAmber,
        unselectedLabelStyle: AppTextStyles.regular13(),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImage.discoverIcon,
              color: _selectedIndex == 0 ? AppColor.lightAmber : AppColor.greyLightest,
              semanticsLabel: AppString.discover,
            ),
            label: AppString.discover,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImage.watchListIcon,
              color: _selectedIndex == 1 ? AppColor.lightAmber : AppColor.greyLightest,
              semanticsLabel: AppString.watchList,
            ),
            label: AppString.watchList,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImage.myPortfolio,
              color: _selectedIndex == 2 ? AppColor.lightAmber : AppColor.greyLightest,
              semanticsLabel: AppString.myPortfolio,
            ),
            label: AppString.myPortfolio,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImage.ordersIcon,
              color: _selectedIndex == 3 ? AppColor.lightAmber : AppColor.greyLightest,
              semanticsLabel: AppString.orders,
            ),
            label: AppString.orders,
          ),
        ],
      ),
    );
  }
}
