import 'package:flutter/material.dart';

/**
 * Note: this code was taken from the rounded_expansion_tile package and was
 * modified to take an isExpanded param
 * 
 * original: https://pub.dev/documentation/rounded_expansion_tile/latest/rounded_expansion_tile/RoundedExpansionTile-class.html
 */
///

class CustomRoundedExpansionTile extends StatefulWidget {
  final bool? autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final bool? dense;
  final bool? enabled;
  final bool? enableFeedback;
  final Color? focusColor;
  final FocusNode? focusNode;
  final double? horizontalTitleGap;
  final Color? hoverColor;
  final bool? isThreeLine;
  final Widget? leading;
  final double? minLeadingWidth;
  final double? minVerticalPadding;
  final MouseCursor? mouseCursor;
  final void Function()? onLongPress;
  final bool? selected;
  final Color? selectedTileColor;
  final ShapeBorder? shape;
  final Widget? subtitle;
  final Widget? title;
  final Color? tileColor;
  final Widget? trailing;
  final VisualDensity? visualDensity;
  final void Function()? onTap;
  final Duration? duration;
  final List<Widget>? children;
  final Curve? curve;
  final EdgeInsets? childrenPadding;
  final bool? rotateTrailing;
  final bool? noTrailing;
  final bool? isExpanded;
  final BoxDecoration? boxDecoration;
  final BorderRadiusGeometry? borderRadius;

  const CustomRoundedExpansionTile(
      {super.key, this.title,
      this.subtitle,
      this.leading,
      this.trailing,
      this.duration,
      this.children,
      this.autofocus,
      this.contentPadding,
      this.dense,
      this.enabled,
      this.enableFeedback,
      this.focusColor,
      this.focusNode,
      this.horizontalTitleGap,
      this.hoverColor,
      this.isThreeLine,
      this.minLeadingWidth,
      this.minVerticalPadding,
      this.mouseCursor,
      this.onLongPress,
      this.selected,
      this.selectedTileColor,
      this.shape,
      this.tileColor,
      this.visualDensity,
      this.onTap,
      this.curve,
      this.childrenPadding,
      this.rotateTrailing,
      this.noTrailing,
      this.isExpanded,
      this.boxDecoration,
      this.borderRadius});

  @override
  _CustomRoundedExpansionTileState createState() => _CustomRoundedExpansionTileState();
}

class _CustomRoundedExpansionTileState extends State<CustomRoundedExpansionTile>
    with TickerProviderStateMixin {
  late bool _expanded;
  bool? _rotateTrailing;
  bool? _noTrailing;
  late AnimationController _controller;
  late AnimationController _iconController;

  // When the duration of the ListTile animation is NOT provided. This value will be used instead.
  Duration defaultDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    // If not provided, will be false
    _expanded = widget.isExpanded ?? false;
    // If not provided, this will be true
    _rotateTrailing =
        widget.rotateTrailing ?? true;
    // If not provided this will be false
    _noTrailing = widget.noTrailing ?? false;
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration ?? defaultDuration);

    _iconController = AnimationController(
      duration: widget.duration ?? defaultDuration,
      vsync: this,
    );

    _controller.forward();
    // _iconController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _iconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: widget.boxDecoration,
            child: ListTile(
              // If bool is not provided the default will be false.
              autofocus: widget.autofocus == null ? false : widget.autofocus!,
              contentPadding: widget.contentPadding,
              // If bool is not provided the default will be false.
              dense: widget.dense ?? false,
              // If bool is not provided the default will be true.
              enabled: widget.enabled == null ? true : widget.enabled!,
              enableFeedback:
                  // If bool is not provided the default will be false.
                  widget.enableFeedback ?? false,
              focusColor: widget.focusColor,
              focusNode: widget.focusNode,
              horizontalTitleGap: widget.horizontalTitleGap,
              hoverColor: widget.hoverColor,
              // If bool is not provided the default will be false.
              isThreeLine:
                  widget.isThreeLine == null ? false : widget.isThreeLine!,
              key: widget.key,
              leading: _leadingIcon(),
              minLeadingWidth: widget.minLeadingWidth,
              minVerticalPadding: widget.minVerticalPadding,
              mouseCursor: widget.mouseCursor,
              onLongPress: widget.onLongPress,
              // If bool is not provided the default will be false.
              selected: widget.selected == null ? false : widget.selected!,
              selectedTileColor: widget.selectedTileColor,
              shape: widget.shape,
              subtitle: widget.subtitle,
              title: widget.title,
              tileColor: widget.tileColor,
              trailing: _noTrailing! ? null : _trailingIcon(),
              visualDensity: widget.visualDensity,
              onTap: () {
                if (widget.onTap != null) {
                  /// Developers who uses this package can add custom functionality when tapped.
                  ///
                  /// When a developer defines an extra option on tap, this will be executed. If not provided this step will be skipped.
                  /// ignore: unnecessary_statements
                  widget.onTap;
                }
                setState(() {
                  // Checks if the ListTile is expanded and sets state accordingly.
                  _expanded = !_expanded;
                  if (_expanded) {
                    _controller.forward();
                    _iconController.reverse();
                  } else {
                    _controller.reverse();
                    _iconController.forward();
                  }
                });
              },
            ),
          ),
          AnimatedCrossFade(
              firstCurve: widget.curve == null
                  ? Curves.fastLinearToSlowEaseIn
                  : widget.curve!,
              secondCurve: widget.curve == null
                  ? Curves.fastLinearToSlowEaseIn
                  : widget.curve!,
              crossFadeState: _expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration:
                  widget.duration == null ? defaultDuration : widget.duration!,
              firstChild:

                  /// Returns Listviews for the children.
                  ///
                  /// ClampingScrollPhyiscs so the ListTile will scroll in the main screen and not its children.
                  /// Shrinkwrap is always true so the ExpansionTile will wrap its children and hide when not expanded.
                  ListView(
                physics: const ClampingScrollPhysics(),
                padding: widget.childrenPadding,
                shrinkWrap: true,
                children: widget.children!,
              ),
              // If not expanded just returns an empty containter so the ExpansionTile will only show the ListTile.
              secondChild: Container()),
        ]);
  }

  Widget? _leadingIcon() {
    if (widget.trailing != null) {
      if (_rotateTrailing!) {
        return RotationTransition(
            turns: Tween(begin: 0.0, end: -0.25).animate(_iconController),
            child: widget.leading);
      } else {
        // If developer sets rotateTrailing to false the widget will just be returned.
        return widget.trailing;
      }
    } else {
      // Default trailing is an Animated Menu Icon.
      return AnimatedIcon(
          icon: AnimatedIcons.menu_close, progress: _controller);
    }
  }

  // Build trailing widget based on the user input.
  Widget? _trailingIcon() {
    if (widget.trailing != null) {
      if (_rotateTrailing!) {
        return RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(_iconController),
            child: widget.trailing);
      } else {
        // If developer sets rotateTrailing to false the widget will just be returned.
        return widget.trailing;
      }
    } else {
      // Default trailing is an Animated Menu Icon.
      return AnimatedIcon(
          icon: AnimatedIcons.close_menu, progress: _controller);
    }
  }
}
