import 'package:flutter/widgets.dart';

import '../../models/project.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  double finalRotation = 0;

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
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // width: screenWidth / 2,
      key: widgetKey,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: Transform.rotate(
        // origin: Offset(0, 300),
        // alignment: Alignment.bottomLeft,
        angle: 10 / 360 + position / 3500,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            widget.project.image,
            fit: BoxFit.contain,
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
