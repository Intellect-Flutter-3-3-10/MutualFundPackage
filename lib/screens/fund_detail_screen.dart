import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/widgets/charts/simple_line_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../my_app_exports.dart';

class FundDetailScreenArgs {
  final String? schemeCode;

  FundDetailScreenArgs(this.schemeCode);
}

class FundDetailScreen extends StatefulWidget {
  final FundDetailScreenArgs args;

  const FundDetailScreen({super.key, required this.args});

  @override
  State<FundDetailScreen> createState() => _FundDetailScreenState();
}

class _FundDetailScreenState extends State<FundDetailScreen> with UtilsMethod {
  final fundDetailController = Get.put(FundDetailController());
  bool isSaved = false;

  // for sip calculation
  bool isSip = true;

  double _value = 0.0;
  double amount = 0.0;
  bool isSipSelected = false;

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  void initState() {
    super.initState();
    fundDetailController.fetchMutualFundOverview(schemeCode: widget.args.schemeCode ?? 'N/A');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("SCHEME CODE >>>>>> ${widget.args.schemeCode}");
    return Scaffold(
      appBar: CommonAppBar(
        title: AppString.fundDetails,
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
      body: LayoutBuilder(
        builder: (BuildContext context, constraint) {
          Size size = MediaQuery.of(context).size;
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.appHPadding,
                vertical: AppDimens.appVPadding,
              ),
              child: Obx(
                () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// fund stats details
                      Obx(() => _fundStatsView(constraints: constraint, size: size)),

                      ///line chart
                      Obx(() => _lineChart(constraint: constraint, size: size)),

                      const SizedBox(height: AppDimens.appSpacing10),

                      /// chart view duration button
                      _chartViewDurationButton(constraint: constraint, size: size),

                      // const SizedBox(height: AppDimens.appSpacing10),

                      /// schema details panel
                      // _schemaDetailsPanel(constraint: constraint, size: size),

                      // const SizedBox(height: AppDimens.appSpacing10),

                      /// returns calculator
                      // _returnsCalculatorPanel(constraint: constraint, size: size),

                      // const SizedBox(height: AppDimens.appSpacing10),

                      /// returns and rankings
                      // _returnsAndRankingView(constraints: constraint, size: size),

                      const SizedBox(height: AppDimens.appSpacing10),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),

      /// invest button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.appSpacing20),
          child: CommonOutlinedButton(
            // borderColor: AppColor.lightAmber,
            btnText: AppString.investNow,
            onTap: () {
              _showBottomSheet();
            },
          ),
        ),
      ),
    );
  }

  /// fund stats view
  Widget _fundStatsView({BoxConstraints? constraints, Size? size}) {
    var fundDetail = FundDetailController.mutualFundData.value.data;
    return Skeletonizer(
      enabled: fundDetailController.isLoading.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomImageCard(
                      image: fundDetail?.amcIcon ?? "",
                      height: size!.height * 0.080,
                      width: size.width * 0.17,
                    ),
                    SizedBox(
                      width: size.height * 0.010,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            fundDetail?.schemeName ?? 'N/A',
                            // " Kotak Emerging Equity",
                            style: AppTextStyles.regular15(),
                            // maxLines: 1,
                            overflow: TextOverflow.visible,
                            // softWrap: true,
                          ),
                          AutoSizeText(
                            fundDetail?.riskCategory ?? 'N?A',
                            style: AppTextStyles.regular13(),
                            // maxLines: ,
                          ),
                          FittedBox(
                            child: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomChip(
                                      label: fundDetail?.assetClass ?? "N/A",
                                    ),
                                    SizedBox(
                                      width: AppDimens.appSpacing10,
                                    ),
                                    CustomChip(
                                      label: fundDetail?.schemeCategory ?? "N/A",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonIconButton(
                    onTap: toggleSave,
                    isSvg: false,
                    icon: isSaved ? Icons.bookmark : Icons.bookmark_border_outlined,
                    pictureIcon: AppImage.all,
                    iconColor: AppColor.blue,
                  ),
                  ShowRatingWidget(
                    rating: "4" ?? "N/A",
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: AppDimens.appSpacing10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.nav,
                    style: AppTextStyles.regular12(color: AppColor.greyLightest),
                  ),
                  Row(
                    children: [
                      Text(
                        fundDetail?.nav.toString() ?? "",
                        style: AppTextStyles.semiBold15(),
                      ),
                      Text(
                        " ${AppString.rupees}${fundDetail?.oneWeekChange?.toStringAsFixed(2)}",
                        style: AppTextStyles.regular15(color: AppColor.green),
                      ),
                    ],
                  ),
                ],
              ),
              TitleAndValueWidget(
                isHorizontal: false,
                crossAxisAlignment: CrossAxisAlignment.end,
                title: AppString.oneWeekReturn,
                value: fundDetail?.oneWeekReturn.toStringAsFixed(2) ?? 'N/A',
                valueColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: AppDimens.appSpacing10),
        ],
      ),
    );
  }

  /// line chart
  Widget _lineChart({BoxConstraints? constraint, Size? size}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Skeletonizer(
      enabled: fundDetailController.isLoading.value,
      child: SizedBox(
        height: constraint!.maxHeight * 0.35,
        width: constraint.maxHeight,
        child: CustomLineChart(
          belowBarGradientColors: isDark
              ? [
                  AppColor.lightAmber,
                  AppColor.lightestAmber,
                  AppColor.black.withOpacity(0.2),
                  AppColor.black,
                ]
              : [
                  AppColor.lightestAmber,
                  AppColor.lightestAmber,
                  AppColor.offWhite,
                  AppColor.white,
                ],
          isCurved: true,
          spots: FundDetailController.historicalNAVDetails.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final point = entry.value;
              return FlSpot(index.toDouble(), point.nav.toPrecision(2) ?? 0);
            },
          ).toList(),
        ),
      ),
    );
  }

  /// chart view duration button
  Widget _chartViewDurationButton({BoxConstraints? constraint, Size? size}) {
    return Skeletonizer(
      enabled: fundDetailController.isLoading.value,
      child: CustomToggleButtons(
        buttonLabels: const ['1D', '1W', '1M', '1Y', 'All'],
        onToggle: (index) {
          debugPrint('Selected Button Index: $index');

          // fundDetailController.fetchFundOverviewCalInfo(
          //   schemeCode: widget.args.schemeCode ?? '',
          //   investmentType: "B",
          //   investedAmount: "500",
          // );
        },

        activeColor: AppColor.lightestAmber,
        inactiveColor: AppColor.white,
        activeTextColor: AppColor.greyLight,
        inactiveTextColor: AppColor.greyLight,
        // borderRadius: 12.0,
        spacing: 8.0,
        buttonHeight: constraint!.maxHeight * 0.045,
        buttonWidth: constraint.maxHeight * 0.070,
      ),
    );
  }

  /// schema details panel
  Widget _schemaDetailsPanel({BoxConstraints? constraint, Size? size}) {
    return Skeletonizer(
      enabled: fundDetailController.isLoading.value,
      child: CustomExpansionPanelList(
        bodyColor: Theme.of(context).scaffoldBackgroundColor,

        panels: [
          CustomExpansionPanel(
            header: AppString.schemaDetails,
            body: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 5 - 1) {
                  return CommonHeader(
                    title: 'Exit Load',
                    titleStyle: AppTextStyles.regular12(),
                    labelColor: AppColor.lightAmber,
                    labelOnTap: () {},
                    actionLabel: 'Click Here',
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TitleAndValueWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              title: 'Fund Type',
                              value: 'Open Ended',
                              valueStyle: AppTextStyles.semiBold14(),
                              titleStyle: AppTextStyles.regular12(),
                            ),
                            const Divider(
                              thickness: 0.8,
                              color: AppColor.greyLightest,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            thickness: 0.5,
                            width: 0.5,
                            color: AppColor.greyLightest,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleAndValueWidget(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              title: 'Benchmark',
                              value: 'Nifty 100 TRI',
                              valueStyle: AppTextStyles.semiBold14(),
                              titleStyle: AppTextStyles.regular12(),
                            ),
                            const Divider(
                              thickness: 0.8,
                              color: AppColor.greyLightest,
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: AppColor.grey300,
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimens.appSpacing10,
                ),
              ),
              itemCount: 5,
            ),
          ),
        ],
        expansionCallbackEnabled: true,
        headerColor: Colors.transparent,
        // bodyColor: Colors.white,
        elevation: 0.0,
        animationDuration: const Duration(milliseconds: 500),
        // headerTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  /// returns calculator view
  Widget _returnsCalculatorPanel({BoxConstraints? constraint, Size? size}) {
    return Skeletonizer(
      enabled: fundDetailController.isLoading.value,
      child: CustomExpansionPanelList(
        expansionCallbackEnabled: true,
        headerColor: Colors.transparent,
        // bodyColor: Colors.white,
        elevation: 0.0,
        animationDuration: const Duration(milliseconds: 500),
        panels: [
          CustomExpansionPanel(
            header: AppString.returnsCalculator,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CommonOutlinedButton(
                        borderColor: AppColor.lightAmber,
                        fgColor: isSip ? AppColor.black : UtilsMethod().getColorBasedOnTheme(context),
                        bgColor: isSip ? AppColor.lightestAmber : Theme.of(context).scaffoldBackgroundColor,
                        // Highlight based on `isSip`
                        btnText: AppString.sip,
                        onTap: () {
                          debugPrint("SIP");
                          setState(() {
                            isSip = true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: AppDimens.appSpacing20,
                    ),
                    Expanded(
                      child: CommonOutlinedButton(
                        fgColor: !isSip ? AppColor.black : UtilsMethod().getColorBasedOnTheme(context),
                        borderColor: AppColor.lightAmber,
                        bgColor: !isSip ? AppColor.lightestAmber : Theme.of(context).scaffoldBackgroundColor,
                        // Highlight when `isSip` is false
                        btnText: AppString.lumpSum,
                        onTap: () {
                          debugPrint("Lumpsum");
                          setState(() {
                            isSip = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.appSpacing10),
                CommonHeader(
                  title: '${AppString.rupees} ${amount.toStringAsFixed(0)}',
                  titleStyle: AppTextStyles.semiBold14(),
                  labelColor: AppColor.greyLightest,
                  actionLabel: AppString.monthlyOrLumpSum,
                ),
                Slider(
                  min: 0.0,
                  max: 10000.0,
                  value: _value,
                  activeColor: AppColor.lightAmber,
                  inactiveColor: AppColor.grey300,
                  onChanged: (double value) {
                    setState(() {
                      _value = value;
                      amount = value;
                    });
                    debugPrint("$_value");
                  },
                ),
                const SizedBox(
                  width: AppDimens.appSpacing20,
                ),
                CommonHeader(
                  title: AppString.selectDuration,
                  titleStyle: AppTextStyles.regular12(),
                  isActionLabel: false,
                  labelColor: AppColor.greyLightest,
                  actionLabel: AppString.monthlyOrLumpSum,
                ),
                const SizedBox(height: AppDimens.appSpacing10),
                CustomToggleButtons(
                  buttonLabels: const ['1 M', '3 M', '6 M', '1 Y', '2 Y', '3 Y'],
                  onToggle: (index) {
                    debugPrint('Selected Button Index: $index');
                  },
                  isOutlined: true,
                  isFittedBox: true,
                  activeColor: AppColor.lightestAmber,
                  inactiveColor: AppColor.white,
                  activeTextColor: UtilsMethod().getColorBasedOnTheme(context),
                  inactiveTextColor: AppColor.greyLightest,
                  // borderRadius: 12.0,
                  spacing: 8.0,
                  buttonHeight: constraint!.maxHeight * 0.045,
                  buttonWidth: constraint.maxHeight * 0.070,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// returns and rankings view
  Widget _returnsAndRankingView({BoxConstraints? constraints, Size? size}) {
    return Skeletonizer(
      enabled: fundDetailController.isLoading.value,
      child: CustomExpansionPanelList(
        headerColor: Colors.transparent,
        elevation: 0.0,
        panels: [
          CustomExpansionPanel(
            header: AppString.returnsAndRankings,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimens.appSpacing10),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.none, // Add this line to remove any underline
                            ),
                        children: [
                          TextSpan(
                            text: 'Total Investments',
                            style: AppTextStyles.regular12()
                                .copyWith(decoration: TextDecoration.none, color: UtilsMethod().getColorBasedOnTheme(context)), // Ensure no underline
                          ),
                          TextSpan(
                              text: 'Rs 15,441',
                              style: AppTextStyles.regular12(color: AppColor.lightAmber).copyWith(
                                decoration: TextDecoration.none,
                              ) // Ensure no underline
                              ),
                          TextSpan(
                              text: ' with return of ',
                              style: AppTextStyles.regular12().copyWith(
                                  decoration: TextDecoration.none, color: UtilsMethod().getColorBasedOnTheme(context)) // Ensure no underline
                              ),
                          TextSpan(
                              text: '42.54%',
                              style: AppTextStyles.regular12(color: AppColor.green).copyWith(
                                decoration: TextDecoration.none,
                              ) // Ensure no underline
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppDimens.appSpacing10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "",
                            style: AppTextStyles.regular14(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Total Value",
                            textAlign: TextAlign.end,
                            style: AppTextStyles.regular14(),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Annualised Rtn%",
                            textAlign: TextAlign.end,
                            style: AppTextStyles.regular12(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDimens.appSpacing10,
                    ),
                    _returnsStateView(progressLabel: 'This Fund', totalAmount: '28,508.00,', annualReturn: '42.54'),
                    const SizedBox(
                      height: AppDimens.appSpacing10,
                    ),
                    _returnsStateView(progressLabel: 'Category Average', totalAmount: '28,508.00,', annualReturn: '34.54'),
                    const SizedBox(
                      height: AppDimens.appSpacing10,
                    ),
                    _returnsStateView(progressLabel: 'Benchmark', totalAmount: '28,508.00,', annualReturn: '40.12'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// returns stats view
  Widget _returnsStateView({
    String? progressLabel,
    double? progressValue,
    String? totalAmount,
    String? annualReturn,
  }) {
    return Skeletonizer(
      enabled: fundDetailController.isLoading.value,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  progressLabel ?? "N/A",
                  textAlign: TextAlign.end,
                  style: AppTextStyles.regular12(),
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 3 / 4,
                  color: AppColor.lightAmber,
                  backgroundColor: AppColor.grey300,
                  // borderRadius: BorderRadius.circular(25),
                )
              ],
            ),
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                text: AppString.rupees,
                style: AppTextStyles.regular14(),
                children: [
                  TextSpan(
                    text: totalAmount,
                    style: AppTextStyles.regular14(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "${annualReturn} %",
              textAlign: TextAlign.end,
              style: AppTextStyles.regular14(),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    debugPrint("bottom sheet");
    UtilsMethod().showBottomSheet(
        context: context,
        child: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CommonOutlinedButton(
                    btnText: AppString.investWithSip,
                    onTap: () {
                      debugPrint("SIP");
                      setState(() {
                        isSipSelected = true;
                      });
                      Get.back(closeOverlays: true);
                      Get.toNamed(
                        AppRoute.orderPlacementScreen,
                        arguments: OrderPlacementScreenArgs(isSip: isSipSelected),
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppDimens.appHPadding),
                Expanded(
                  child: CommonOutlinedButton(
                    btnText: AppString.lumpSum,
                    onTap: () {
                      debugPrint("Lumpsum");
                      setState(() {
                        isSipSelected = false;
                      });
                      Get.back(closeOverlays: true);
                      Get.toNamed(
                        AppRoute.orderPlacementScreen,
                        arguments: OrderPlacementScreenArgs(isSip: isSipSelected),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.appVPadding),
            AutoSizeText(
              AppString.sipDesc,
              style: AppTextStyles.regular13(),
            )
          ],
        ));
  }
}
