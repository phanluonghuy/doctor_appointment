import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
// ! It contains all the utilities which help you in your project

  static void changeNodeFocus(BuildContext context,
      {FocusNode? current, FocusNode? next}) {
    current!.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context,
      {bool isBottom = true}) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: (isBottom) ? FlushbarPosition.BOTTOM : FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context,
      {bool isBottom = true}) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition:  (isBottom) ? FlushbarPosition.BOTTOM : FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        // Success color
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.check_circle,
          size: 28,
          color: Colors.white, // Icon color
        ),
      )..show(context),
    );
  }


  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  // average for ratings

  static double averageRatings(List<int> ratings) {
    double avg = 0;
    for (int i = 0; i < ratings.length; i++) {
      avg += ratings[i];
    }
    avg /= ratings.length;

    return avg;
  }

  static String formatTimestamp(DateTime timestamp) {
    return DateFormat('hh:mm a').format(timestamp);
  }

  static String formatDate(DateTime timestamp) {
    return DateFormat('MM/dd/yyyy').format(timestamp);
  }

  static MessageType getMessageType(String messageType) {
    switch (messageType) {
      case 'text': return MessageType.text;
      case 'image': return MessageType.image;
      default: return MessageType.text;
    }
  }

  static MessageStatus getMessageStatus(String status) {
    switch (status) {
      case 'read': return MessageStatus.read;
      case 'delivered': return MessageStatus.delivered;
      case 'sent': return MessageStatus.pending;
      default: return MessageStatus.pending;
    }
  }

}
