import 'package:flutter/material.dart';
import 'package:team_finder_app/core/util/constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:150,
      height: 115,
      child: Center(
        child: Container(
          width: 150,
          height: 115,
          decoration: const ShapeDecoration(
            color: AppLightColors.primaryColor,
            shape: OvalBorder(),
          ),
          child: const Center(
            child: Icon(
              size: 90,
              color: Colors.white,
              Icons.handshake,
            ),
          ),
        ),
      ),
    );
  }
}
