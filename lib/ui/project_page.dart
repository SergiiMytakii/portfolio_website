import 'package:flutter/material.dart';
import 'package:portfolio_website/ui/portfolio_page.dart';

import '../models/project.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key, this.project, required this.initialProject});
  static const String routeName = '/project';
  final Project? project;
  final int initialProject;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 1), // Set the duration here
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = 0.0;
                var end = 1.0;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                return FadeTransition(
                  opacity: animation.drive(tween),
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) {
                return PortfolioPage(
                  initialProject: initialProject,
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(project?.title ?? ''),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/bringit.jpeg',
                          width: screenWidth / 3 - 22,
                        ),
                        Hero(
                          tag: project?.title ?? '',
                          child: Image.asset(project?.image ?? '',
                              width: screenWidth / 3 - 22),
                        ),
                        Image.asset('assets/images/bringit.jpeg',
                            width: screenWidth / 3 - 22)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
