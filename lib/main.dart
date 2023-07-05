import 'package:flutter/material.dart';
import 'package:portfolio_website/ui/portfolio_page.dart';
import 'package:portfolio_website/ui/project_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      routes: {
        ProjectPage.routeName: (context) => ProjectPage(
              initialProject: 0,
            ),
      },
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}
