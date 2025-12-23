import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size ScreenSize = MediaQuery.sizeOf(context);
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AssetsPath.backgroundSVG,
            fit: BoxFit.cover,
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
