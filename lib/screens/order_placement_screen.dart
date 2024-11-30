import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/controller/order_place_controller/order_place_controller.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

class OrderPlacementScreenArgs {
  final bool isSip;

  OrderPlacementScreenArgs({
    this.isSip = false,
  });
}

class OrderPlacementScreen extends StatefulWidget {
  final OrderPlacementScreenArgs? args;

  const OrderPlacementScreen({
    super.key,
    this.args,
  });

  @override
  State<OrderPlacementScreen> createState() => _OrderPlacementScreenState();
}

class _OrderPlacementScreenState extends State<OrderPlacementScreen> {
  final TextEditingController _enterAmount = TextEditingController();
  OrderPlaceController orderController = OrderPlaceController();

  // for radio button
  int _selectedValue = 0;

  // for checkbox
  bool _isStepUpSip = false;
  bool _isAssistedByEmpOrAgent = false;
  bool _termsAndCondition = false;

  @override
  void dispose() {
    _enterAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var args = Get.arguments as OrderPlacementScreenArgs;
    debugPrint("SIP Selected  >>>>>>${args.isSip}");
    debugPrint("SIP Selected Args  >>>>>>${widget.args!.isSip}");
    return Scaffold(
      appBar: const CommonAppBar(
        title: AppString.orderPlacementScreen,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.appHPadding,
                vertical: AppDimens.appVPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// fund stats view
                  _fundStatsView(size: size, constraints: constraints),

                  const SizedBox(height: AppDimens.appSpacing10),

                  /// invest action view
                  _investActionView(constraints: constraints, size: size),

                  const SizedBox(height: AppDimens.appSpacing20),

                  /// sip date
                  args.isSip ? _sipDateView(size: size, constraints: constraints) : const SizedBox.shrink(),

                  args.isSip ? const SizedBox(height: AppDimens.appSpacing10) : const SizedBox.shrink(),

                  /// nominee view
                  _nomineeView(constraints: constraints, size: size),

                  const SizedBox(height: AppDimens.appSpacing20),

                  /// expansion view with checkbox
                  _expansionView(size: size, constraints: constraints),

                  const SizedBox(height: AppDimens.appSpacing20),

                  /// payment options view
                  CommonHeader(
                    title: AppString.paymentMethods,
                    titleStyle: AppTextStyles.regular15(),
                    isActionLabel: false,
                  ),
                  const SizedBox(height: AppDimens.appSpacing10),
                  _paymentTile(
                      title: AppString.bankTransfer,
                      icon: AppImage.bankIcon,
                      subtitle: AppString.selectYourBankAccount,
                      onTap: () {},
                      isSvg: true,
                      size: size),
                  const SizedBox(height: AppDimens.appSpacing10),
                  _paymentTile(
                    title: AppString.upiTransfer,
                    icon: AppImage.upiIcon,
                    subtitle: '....Bank....2234',
                    onTap: () {},
                    isSvg: true,
                    size: size,
                  ),
                  const SizedBox(height: AppDimens.appSpacing20),

                  /// final button
                  CommonOutlinedButton(
                    height: size.height * 0.065,
                    btnText: AppString.placeOrder,
                    onTap: placeOrder,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void placeOrder() async {
    var sipOrder = AddSipOrderModel(
      clientCode: 'G000001',
      transactionCode: 'NEW',
      dpType: 'CDSL',
      frequencyType: 'MONTHLY',
      schemeCode: '02-DP',
      startDate: '01/12/2024',
      remarks: 'Test Order',
      installmentAmount: '5000',
      noOfIntellments: '100',
      purchaseType: 'TEmp',
      folioNumber: '',
    );

    var order = AddOrderModel(
      clientCode: 'G000001',
      transactionCode: 'NEW',
      buySell: 'PURCHASE',
      buySellType: 'FRESH',
      dpType: 'CDSL',
      schemeCode: '02-DP',
      amount: 1000,
      quantity: 0,
      folioNumber: '',
      remarks: 'Test Order',
      allRedeem: true,
    );

    widget.args!.isSip ? await orderController.addSipOrder(sipOrder) : orderController.addOrder(order);
  }

  /// fund stats view
  Widget _fundStatsView({BoxConstraints? constraints, Size? size}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: size!.height * 0.080,
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.greyLightest.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(AppDimens.appRadius6)),
                ),
                SizedBox(
                  width: size.height * 0.010,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      'LIC MF Infrastructure Fund',
                      style: AppTextStyles.regular15(),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '- Growth Plan',
                      style: AppTextStyles.regular13(),
                      maxLines: 1,
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            CustomChip(
                              label: 'Equity',
                            ),
                            SizedBox(
                              width: AppDimens.appSpacing10,
                            ),
                            CustomChip(
                              label: 'Mid Cap',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                ShowRatingWidget(
                  rating: '4',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: AppDimens.appSpacing10,
        ),
        const Divider(
          color: AppColor.grey300,
          thickness: 0.6,
        ),
      ],
    );
  }

  /// invest action view
  Widget _investActionView({BoxConstraints? constraints, Size? size}) {
    var args = Get.arguments as OrderPlacementScreenArgs;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoSizeText(
          args.isSip ? AppString.monthlyAmount : AppString.lumpsumAmount,
          style: AppTextStyles.regular16(),
          maxLines: 1,
          softWrap: true,
        ),
        const SizedBox(height: AppDimens.appSpacing10),
        SizedBox(
          width: size!.width / 3,
          child: TextField(
            style: AppTextStyles.regular16(),
            controller: _enterAmount,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: AppString.enterAmount,
              prefixIconConstraints: BoxConstraints(minWidth: 25, maxHeight: 25),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0), // Add some padding if needed
                child: Text(AppString.rupees),
              ),
              isDense: false,
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.greyLightest),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.greyLightest, width: 1.5),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.greyLightest),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.appSpacing10),
        SizedBox(
          height: size.height * 0.042,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.appSpacing5,
              ),
            ),
            itemBuilder: (context, index) {
              return CustomPriceChip(
                textColor: AppColor.black,
                text: "+ ${AppString.rupees}${index + 1}00",
                onTap: () {
                  debugPrint("${index + 1}");
                },
              );
            },
            itemCount: 5,
          ),
        ),
        const SizedBox(height: AppDimens.appSpacing10),
        AutoSizeText(
          AppString.minAmountDesc,
          style: AppTextStyles.regular12(),
        ),
      ],
    );
  }

  /// sip date view
  Widget _sipDateView({BoxConstraints? constraints, Size? size}) {
    return CommonOutLinedContainer(
      borderColor: AppColor.greyLightest,
      bgColor: Colors.transparent,
      borderRadius: AppDimens.appRadius6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            AppString.sipDate,
            style: AppTextStyles.regular12(),
          ),
          Row(
            children: [
              AutoSizeText(
                "16th ${AppString.ofEveryMonth}",
                style: AppTextStyles.semiBold14(
                    // color: AppColor.greyLightest,
                    ),
              ),
              const SizedBox(
                width: AppDimens.appSpacing5,
              ),
              SvgPicture.asset(
                AppImage.calenderIcon,
                color: UtilsMethod().getColorBasedOnTheme(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// add nominee view
  Widget _nomineeView({BoxConstraints? constraints, Size? size}) {
    return FittedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            AppString.addNominee,
            style: AppTextStyles.semiBold14(),
          ),
          Row(
            children: [
              SizedBox(
                width: size!.width / 3,
                child: CustomRadioTile<int>(
                  title: AppString.yes,
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: size.width / 1.5,
            child: CustomRadioTile<int>(
              title: AppString.noIDont,
              value: 2,
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  /// expansion tile
  Widget _expansionView({BoxConstraints? constraints, Size? size}) {
    var args = Get.arguments as OrderPlacementScreenArgs;
    bool isExpanded = true;
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: CustomExpansionPanelList(
        headerColor: Colors.transparent,
        bodyColor: AppColor.darkPurple,
        elevation: 0,
        expansionCallbackEnabled: true,
        headerTextStyle: AppTextStyles.regular15(),
        panels: [
          CustomExpansionPanel(
            header: '',
            isExpanded: isExpanded,
            // isExpanded: ,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                args.isSip
                    ? CustomCheckboxTile(
                        title: AppString.stepUpSip,
                        titleStyle: AppTextStyles.regular14(color: AppColor.white),
                        value: _isStepUpSip,
                        selected: _isStepUpSip,
                        onChanged: (bool? value) {
                          setState(() {
                            _isStepUpSip = value!;
                          });

                          debugPrint("  step up sip >>>>> $_isStepUpSip");
                        },
                        trailingIcon: Icons.info,
                        iconColor: AppColor.white,
                        iconSize: 18,
                      )
                    : const SizedBox.shrink(),
                CustomCheckboxTile(
                  title: AppString.assistedByEmployeeOrAgent,
                  titleStyle: AppTextStyles.regular14(color: AppColor.white),
                  value: _isAssistedByEmpOrAgent,
                  selected: _isAssistedByEmpOrAgent,
                  onChanged: (value) {
                    setState(() {
                      _isAssistedByEmpOrAgent = value!;
                    });
                    debugPrint("  step up sip >>>>> $_isAssistedByEmpOrAgent");
                  },
                  // trailingIcon: Icons.warning,
                  // iconColor: AppColor.white,
                  // iconSize: 18,
                ),
                CustomCheckboxTile(
                  title: AppString.termsAndCondition,
                  titleStyle: AppTextStyles.regular14(color: AppColor.white),
                  value: _termsAndCondition,
                  selected: _termsAndCondition,
                  onChanged: (value) {
                    setState(() {
                      _termsAndCondition = value!;
                    });
                    debugPrint("  step up sip >>>>> $_termsAndCondition");
                  },
                  // trailingIcon: Icons.warning,
                  // iconColor: AppColor.white,
                  // iconSize: 18,
                ),
                const SizedBox(
                  height: AppDimens.appSpacing20,
                ),
                FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: 'By Proceeding, I agree with ',
                      style: AppTextStyles.regular10(),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Disclosure and Terms & Conditions.',
                          style: AppTextStyles.semiBold12(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentTile({String? icon, String? title, String? subtitle, Function()? onTap, bool isSvg = false, Size? size}) {
    return SizedBox(
      child: CommonOutLinedContainer(
        borderColor: AppColor.greyLightest,
        bgColor: Colors.transparent,
        vPadding: AppDimens.appSpacing10,
        hPadding: AppDimens.appSpacing10,
        borderRadius: AppDimens.appRadius6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon ?? AppImage.bankIcon,
                  width: size!.height * 0.050,
                  height: size.height * 0.050,
                ),
                const SizedBox(width: AppDimens.appSpacing10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title ?? AppString.bankTransfer,
                      style: AppTextStyles.regular14(),
                    ),
                    AutoSizeText(
                      subtitle ?? AppString.selectYourBankAccount,
                      style: AppTextStyles.regular10(color: AppColor.greyLightest),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
