import 'package:doctor_appointment/res/widgets/buttons/backArrowButton.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:doctor_appointment/view/started/stared_third_screen.dart';
import 'package:doctor_appointment/view/started/started_first_screen.dart';
import 'package:doctor_appointment/view/started/stated_second_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({super.key});

  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: <Widget>[
            StatedFirstScreen(),
            StatedSecondScreen(),
            StatedThirdScreen(),
          ],
        ),
        PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

/// Page indicator for desktop and web platforms.
///
/// On Desktop and Web, drag gesture for horizontal scrolling in a PageView is disabled by default.
/// You can defined a custom scroll behavior to activate drag gestures,
/// see https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag.
///
/// In this sample, we use a TabPageSelector to navigate between pages,
/// in order to build natural behavior similar to other desktop applications.
class PageIndicator extends StatelessWidget {
  const PageIndicator(
      {Key? key,
      required this.tabController,
      required this.currentPageIndex,
      required this.onUpdateCurrentPageIndex})
      : super(key: key);

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BackArrowButton(
                isArrow: false,
                onPressed: () {
                  if (currentPageIndex > 0) {
                    onUpdateCurrentPageIndex(currentPageIndex - 1);
                  } else {
                    Navigator.of(context).pop();
                  }
                }),
            TabPageSelector(
              controller: tabController,
              selectedColor: AppColors.primaryColor,
              indicatorSize: 15,
            ),
            BackArrowButton(
                isArrow: true,
                onPressed: () {
                  if (currentPageIndex < tabController.length - 1) {
                    onUpdateCurrentPageIndex(currentPageIndex + 1);
                  } else {
                    context.push('/login');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
