import 'package:flutter/material.dart';
import 'package:team_finder_app/core/util/constants.dart';

class ChangeAuthPageText extends StatelessWidget {
  const ChangeAuthPageText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        ///TODO: implement change to login screen
      },
      child: const Text(
        AuthConstants.alreadyHaveAnAccount,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    );
  }
}

