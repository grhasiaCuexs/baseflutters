import 'package:flutter/material.dart';
import 'package:myeshop/modules/root/presentation/ui/components/global_widget.dart';

class ErrorData {
  const ErrorData(this.title, this.desc);
  final String title;
  final String desc;
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ScreenStateHelpersWidget extends StatelessWidget {
  ScreenStateHelpersWidget({
    super.key,
    required this.isLoading,
    ErrorData? errorData,
    String? errorString,
    required this.onSuccess,
    this.onRefresh,
  }) : _errorData = errorString != null
            ? ErrorData("Maaf Terjadi Kesalahan", errorString)
            : errorData;

  final bool isLoading;
  final ErrorData? _errorData;
  final Widget Function(BuildContext context) onSuccess;
  final Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? GlobalWidgets().isLoading()
        : _errorData != null
            ? CommonErrorWidget(
                title: _errorData.title,
                desc: _errorData.desc,
                onTapButton: onRefresh,
              )
            : onSuccess(context);
  }
}
