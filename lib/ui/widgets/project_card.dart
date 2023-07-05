import 'package:flutter/widgets.dart';
import 'package:portfolio_website/ui/project_page.dart';

import '../../models/project.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard(
      {super.key, required this.project, required this.initialProject});

  final Project project;
  final int initialProject;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey widgetKey = GlobalKey();
  double position = 0;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
    _animationController!.addListener(() {
      setState(() {
        position = getWidgetCoordinates(widgetKey).dy;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProjectPage(
              project: widget.project,
              initialProject: widget.initialProject,
            ),
            transitionDuration:
                const Duration(seconds: 1), // Set the duration here
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var curve = Curves.easeInCirc;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: SizedBox(
        key: widgetKey,
        child: Transform.rotate(
          angle: 10 / 360 + position / 3500,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Hero(
              tag: widget.project.title,
              child: Image.asset(
                widget.project.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Offset getWidgetCoordinates(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final topLeftPosition = renderBox.localToGlobal(Offset.zero);
      return topLeftPosition;
    }
    return Offset.zero;
  }
}
