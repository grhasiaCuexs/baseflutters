import 'package:flutter/material.dart';

class CommonInfoWidget extends StatelessWidget {
  const CommonInfoWidget(
      {super.key, required this.title, this.subTitle = "", required this.imgAsset});

  final String title;
  final String subTitle;
  final String imgAsset;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imgAsset,
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: width - 80,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF070B2E),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF070B2E),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    height: 0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
