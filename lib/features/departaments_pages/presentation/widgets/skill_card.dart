import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String skillName;
  final String skillDescription;
  final String skillAuthor;

  const SkillCard({
    super.key,
    required this.skillName,
    required this.skillDescription,
    required this.skillAuthor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/carnetel.png',
              ),
              Center(
                child: Text(
                  skillName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                skillDescription,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                skillAuthor,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          )),
    );
  }
}
