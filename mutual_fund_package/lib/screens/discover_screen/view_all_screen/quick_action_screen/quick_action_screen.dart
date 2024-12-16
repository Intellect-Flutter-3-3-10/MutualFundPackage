import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../my_app_exports.dart';

class QuickActionScreenArgs {
  final int? tabIndex;
  final String? indexName;

  QuickActionScreenArgs({this.tabIndex, this.indexName});
}

class QuickActionScreen extends StatefulWidget {
  final QuickActionScreenArgs args;

  const QuickActionScreen({super.key, required this.args});

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

    /// for initializing selected tab from prev screen
    int initialIndex = (widget.args.tabIndex ?? 0).clamp(0, _tabs.length - 1);
    _tabController = TabController(length: _tabs.length, vsync: this, initialIndex: initialIndex);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments as QuickActionScreenArgs;
    debugPrint("initial tab index >>>>> ${args.tabIndex} ");

    return Scaffold(
      appBar: CommonAppBar(
        title: AppString.quickActions,
        action: [
          IconButton(
            onPressed: () {
              UtilsMethod().navigateTo(context, AppRoute.searchScreen);
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
