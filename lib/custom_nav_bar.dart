import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.unSelectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.barMargin = const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 15,
    ),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  });

  final List<NavBarButtonItem> items;
  final int currentIndex;
  final Function(int value)? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedColorOpacity;
  final double? unSelectedColorOpacity;
  final ShapeBorder itemShape;
  final EdgeInsets margin;
  final EdgeInsets barMargin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          if (backgroundColor != null)
            BoxShadow(
              color: backgroundColor!.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
        ],
      ),
      margin: barMargin,
      child: SafeArea(
        minimum: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final isSelected = items.indexOf(item) == currentIndex;
            final selectedColor =
                item.selectedColor ?? selectedItemColor ?? theme.primaryColor;
            final unselectedColor = item.unselectedColor ??
                unselectedItemColor ??
                theme.iconTheme.color;

            return TweenAnimationBuilder<double>(
              tween: Tween(end: isSelected ? 1.0 : 0.0),
              curve: curve,
              duration: duration,
              builder: (context, t, _) {
                return Material(
                  color: Color.lerp(
                    selectedColor.withOpacity(unSelectedColorOpacity ?? 0.0),
                    selectedColor.withOpacity(selectedColorOpacity ?? 0.1),
                    t,
                  ),
                  shape:
                      isSelected ? const StadiumBorder() : const CircleBorder(),
                  child: InkWell(
                    onTap: () => onTap?.call(items.indexOf(item)),
                    customBorder: itemShape,
                    focusColor: selectedColor.withOpacity(0.1),
                    highlightColor: selectedColor.withOpacity(0.1),
                    splashColor: selectedColor.withOpacity(0.1),
                    hoverColor: selectedColor.withOpacity(0.1),
                    child: Padding(
                      padding: itemPadding -
                          (Directionality.of(context) == TextDirection.ltr
                              ? EdgeInsets.only(right: itemPadding.right * t)
                              : EdgeInsets.only(left: itemPadding.left * t)),
                      child: Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color:
                                  Color.lerp(unselectedColor, selectedColor, t),
                              size: 24,
                            ),
                            child: isSelected
                                ? item.activeIcon ??
                                    CircleAvatar(
                                      backgroundColor: backgroundColor,
                                      child: item.icon,
                                    )
                                : item.icon,
                          ),
                          ClipRect(
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox(
                              height: 20,
                              child: Align(
                                alignment: const Alignment(-0.2, 0.0),
                                widthFactor: t,
                                child: Padding(
                                  padding: Directionality.of(context) ==
                                          TextDirection.ltr
                                      ? EdgeInsets.only(
                                          left: itemPadding.left / 2,
                                          right: itemPadding.right)
                                      : EdgeInsets.only(
                                          left: itemPadding.left,
                                          right: itemPadding.right / 2),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Color.lerp(
                                          selectedColor.withOpacity(0.0),
                                          selectedColor,
                                          t),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    child: item.title,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// A tab to display in a [CustomNavBar]
class NavBarButtonItem {
  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;

  NavBarButtonItem({
    required this.icon,
    required this.title,
    this.selectedColor = Colors.white,
    this.unselectedColor = Colors.white,
    this.activeIcon,
  });
}
