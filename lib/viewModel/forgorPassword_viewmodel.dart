import 'package:doctor_appointment/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  bool _isLoading = false;
  String _token = "";

  bool get loading => _isLoading;
  String get token => _token;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  PageController get pageController => _pageController;
  TabController get tabController => _tabController;
  int get currentPageIndex => _currentPageIndex;

  ForgotPasswordViewModel(TickerProvider vsync) {
    _pageController = PageController();
    _tabController = TabController(length: 4, vsync: vsync);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void handlePageViewChanged(int index) {
    _tabController.index = index;
    _currentPageIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPageIndex < 3) {
      _currentPageIndex++;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPageIndex > 0) {
      _currentPageIndex--;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  Future<void> apiSendOTP(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _repository.sendOTP(data);
      if (value.acknowledgement == false) {
        Utils.flushBarErrorMessage(value.description ?? "", context);
        return;
      }
      Utils.flushBarSuccessMessage(value.description ?? "", context);
      _token = value.data;
      nextPage();
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoading(false);
    }
  }
  Future<void> apiVerifyOTP(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _repository.verifyOTP(data);
      // print(value);
      if (value.acknowledgement ?? false) {
        Utils.flushBarSuccessMessage(value.description ?? "", context);
        nextPage();
      } else {
        Utils.flushBarErrorMessage(value.description?? "", context);
      }

    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoading(false);
    }
  }
  Future<void> apiChangePassword(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _repository.resetPassword(data);
      // print(value);
      if (value.acknowledgement ?? false) {
        Utils.flushBarSuccessMessage(value.description ?? "", context);
        nextPage();
      } else {
        Utils.flushBarErrorMessage(value.description?? "", context);
      }

    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoading(false);
    }
  }

}
