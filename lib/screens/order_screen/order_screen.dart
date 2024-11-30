import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_app_exports.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
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
        title: AppString.myPortfolio,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.appVPadding,
            horizontal: AppDimens.appHPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabBar(
                isScrollable: false,
                physics: const ScrollPhysics(),
                indicatorColor: UtilsMethod().getColorBasedOnTheme(context),
                // labelStyle: AppTextStyles.semiBold15(color: AppColor.greyLight),
                // unselectedLabelStyle: AppTextStyles.regular15(color: AppColor.greyLight),
                // labelColor: AppColor.greyLight,
                enableFeedback: true,
                tabs: const [
                  Tab(
                    text: AppString.active,
                  ),
                  Tab(
                    text: AppString.closed,
                  ),
                ],
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
                  children: const [
                    ActiveFundScreen(),
                    ClosedFundScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
