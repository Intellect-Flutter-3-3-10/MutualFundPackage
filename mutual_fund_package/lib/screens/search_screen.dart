import 'package:flutter/material.dart';

import '../my_app_exports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<Tab> _tabs = [
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(
        title: AppString.search,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              // horizontal: AppDimens.appHPadding,
              // vertical: AppDimens.appVPadding,
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.appHPadding,
                  // vertical: AppDimens.appVPadding,
                ),
                height: size.height * 0.055,
                child: const CustomTextField(
                  hintText: AppString.searchYourFund,
                  prefixIcon: Icons.search,
                ),
              ),
              const SizedBox(height: AppDimens.appSpacing10),
              TabBar(
                isScrollable: true,
                physics: const ScrollPhysics(),
                indicatorColor: UtilsMethod().getColorBasedOnTheme(context),
                // labelStyle: AppTextStyles.semiBold15(
                //   color: UtilsMethod().getColorBasedOnTheme(context),
                // ),
                // unselectedLabelStyle: AppTextStyles.regular15(
                //     // color: UtilsMethod().getColorBasedOnTheme(context),
                //     ),
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
        ),
      ),
    );
  }
}
/*
Today's Update Today I worked on Bigul UI design changes on 3 screens changes password, login screen, create password
and Taking overview of Bigul project flow and understanding how it works based on that from the sheet i have resolved issue which im not able to test because market closed and not allowing me to make a trade tommorow will see the result of resolved.
 */
