import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';

import '../../res/res.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? leadingAction; // Custom action for the leading icon
  final bool automaticallyImplyLeading;
  final bool isBackButton;
  final List<Widget>? action;

  const CommonAppBar({
    super.key,
    this.title = AppString.mutualFunds,
    this.leadingAction,
    this.action,
    this.automaticallyImplyLeading = false,
    this.isBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      // scrolledUnderElevation: 0.0,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: isBackButton
          ? GestureDetector(
              onTap: leadingAction ?? () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios),
            )
          : const SizedBox.shrink(),
      elevation: 0,
      title: AutoSizeText(
        title ?? '',
        style: AppTextStyles.regular20(),
        maxLines: 1,
      ),
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
