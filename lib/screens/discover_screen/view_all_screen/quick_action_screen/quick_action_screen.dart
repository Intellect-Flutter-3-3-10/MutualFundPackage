import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../my_app_exports.dart';

class QuickActionScreen extends StatefulWidget {
  const QuickActionScreen({super.key});

  @override
  State<QuickActionScreen> createState() => _QuickActionScreenState();
}

class _QuickActionScreenState extends State<QuickActionScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<Tab> _tabs = const [
    Tab(
      text: AppString.all,
    ),
    Tab(
      text: AppString.largeCap,
    ),
    Tab(
      text: AppString.midCap,
    ),
    Tab(
      text: AppString.smallCap,
    ),
    Tab(
      text: AppString.largeAndMid,
    ),
    Tab(
      text: AppString.debt,
    ),
    Tab(
      text: AppString.hybrid,
    ),
    Tab(
      text: AppString.elss,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: AppString.quickActions,
        action: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoute.searchScreen);
            },
            icon: Icon(
              Icons.search,
              color: UtilsMethod().getColorBasedOnTheme(context),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            physics: const ScrollPhysics(),
            indicatorColor: UtilsMethod().getColorBasedOnTheme(context),
            // labelStyle: AppTextStyles.semiBold15(
            //   color: UtilsMethod().getColorBasedOnTheme(context),
            // ),
            // unselectedLabelStyle: AppTextStyles.regular15(
            //   color: UtilsMethod().getColorBasedOnTheme(context),
            // ),
            // labelColor: AppColor.greyLight,
            tabs: _tabs,
            controller: _tabController,
            onTap: (value) {
              _tabController?.animateTo(
                _tabController!.index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const ScrollPhysics(),
              children: const [
                AllTabScreen(),
                LargeCapScreen(),
                MidCapScreen(),
                SmallCapScreen(),
                LargeAndMidScreen(),
                DebtScreen(),
                HybridScreen(),
                ElssScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
